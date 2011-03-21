#!/bin/bash

#####################################################
#             ADMINISTRACION DE SISTEMAS            #
#     PRACTICA 1: Usuarios y proteccion en Linux    #
# ------------------------------------------------- #
# ALUMNOS    : Alejandro Samarin Perez   (alu3862)  #
#            : Jose Lucas Grillo Lorenzo (alu3181)  # 
# FECHA      : 14/03/2011                           #
# DESCRIPCION: Este script crea varios usuarios en  #
#              el sistema teniendo en cuenta diver- #
#              sas medidas de seguridad y tecnicas  #
#              de trabajo en grupo.                 #
#####################################################

# --------------------------------------------------------------------------------

# FUNCION    : create_user
# DESCRIPCION: Crea en el sistema un nuevo usuario
# ARGUMENTOS : 
#   $1 => Nombre de usuario
#   $2 => Lista de grupos suplementarios del usuario (Ej: "cc,aeropuerto,parque")
function create_user {
   echo "[+] Creando usuario '$1'"
   # Crear el usuario obtenido en el primer argumento de la funcion, con
   # su directorio de conexion establecido en /home, grupo propio (-U),
   # shell bash estandar y los grupos suplementarios especificados en el
   # segundo argumento de la funcion
   useradd -m -d /home/$1 -U -s /bin/bash -G $2 $1

   # Cambiar la password del nuevo usuario (igual que su username)
   echo $1:$1 | chpasswd

   # Cambiar los parametros de caducidad de su password, segun se indica:
   #   -M 90 => La contrasenya caduca en 3 meses
   #   -W 1  => Se informara al usuario 1 dia antes de la caducidad de la misma
   #   -I 2  => 2 dias tras la expiracion, la cuenta del usuario sera deshabilitada
   chage -M 90 -W 1 -I 2 $1

   # Root sera el propietario de su directorio de conexion, para que el 
   # usuario no pueda modificar los permisos del mismo
   chown root /home/$1

   # Estableciendo permisos "rwxrwx---" se asegura que el usuario
   # puede crear, modificar y borrar ficheros y directorios en su 
   # 'home', a la vez que se previene que otros usuarios puedan acceder
   chmod 770 /home/$1

   # Establecer las cuotas de usuario:
   #   Limite blando (por bloques) => 50MB
   #   Limite duro (por bloques)   => 60MB
   #   Sin limite de inodos
   setquota $1 50000 60000 0 0 -a

   # Establecer el periodo de gracia a la hora de rebasar el limite blando (2 dias)
   setquota $1 -T 2 0 -a 2&>/dev/null
}

# --------------------------------------------------------------------------------

# FUNCION    : set_fstab
# DESCRIPCION: Modifica el fichero /etc/fstab para activar en el sistema el uso
#              de cuotas de usuario y listas de control de acceso (ACL); en caso
#              necesario, remonta la particion /home y 
# ARGUMENTOS : Ninguno
function set_fstab {
   local remount_needed=false

   # Comprobar si estaban seteadas las cuotas en la particion de /home
   if [[ -z `grep -v "^\s*#" /etc/fstab | grep usrjquota` ]]
   then
      echo "[*] Cuotas no establecidas previamente en /etc/fstab, modificando..."
      sed -r 's/^\s*[^#]\S*\s+\/home\s+\S+\s+\S+/&,usrjquota=aquota.user,jqfmt=vfsv0/' -i.bkp1 /etc/fstab
      remount_needed=true
   else 
      echo "[+] Cuotas establecidas previamente"
   fi
   
   # Idem para las listas de control de acceso (ACL)
   if [[ -z `grep -v "^\s*#" /etc/fstab | grep acl` ]]
   then
      echo "[*] ACL's no establecidas previamente en /etc/fstab, modificando..."
      sed -r 's/^\s*[^#]\S*\s+\/home\s+\S+\s+\S+/&,acl/' -i.bkp2 /etc/fstab
      remount_needed=true
   else
      echo "[+] ACL's establecidas previamente"
   fi

   # Si hubo algun cambio en las comprobaciones anteriores, es necesario remontar /home
   # Tambien se activan aqui las cuotas
   if ($remount_needed)
   then
      echo "[+] Remontando /home y comprobando cuotas..."
      umount /home
      fsck /home
      mount /home
      quotacheck -vnm /home
      quotaon -av
   fi
}

# --------------------------------------------------------------------------------

# FUNCION    : create_ls
# DESCRIPCION: Crea un pequenyo programa ejecutable en C que emula un 'ls', pensado
#              para ser utilizado por los ejecutivos que desean observar el desarrollo
#              de proyectos a los cuales no estan asignados; posteriormente se compila
#              este codigo fuente y se coloca el ejecutable en '/usr/local/bin'
#              El nombre del ejecutable generado tiene la forma 'ls<proyecto>'
# ARGUMENTOS :
#   $1 => Nombre del proyecto (Ej: "aeropuerto" genera '/usr/local/bin/lsaeropuerto')
function create_ls {
   # Crear en /tmp el codigo fuente en C
   echo "
#include <stdio.h>
#include <unistd.h>

void main() {
   execl(\"/bin/ls\", \"/bin/ls\", \"-l\", \"/home/proyectos/${1}\", NULL); 
}" > /tmp/ls$1.c
   
   # Compilar el programa C creado y depositar el ejecutable resultante en el
   # directorio destino '/usr/local/bin'
   gcc /tmp/ls$1.c -o /usr/local/bin/ls$1

   # Cambiar UGO y grupo del nuevo ejecutable para que solamente pueda ser
   # utilizado por los ejecutivos
   chgrp ejecutivos /usr/local/bin/ls$1
   chmod -v 4770 /usr/local/bin/ls$1

   # Eliminar el codigo fuente temporal, ya que no es necesario en este punto
   rm /tmp/ls$1.c
}

function set_pam {
   # Invocar a sed para incluir el soporte para el control de tiempos en los ficheros
   # de configuracion de las PAM
   sed -r 's/(account\s+required.*)+/account    required     pam_time.so\n&/m' -i.bkp /etc/pam.d/login

   # Crear backup del fichero /etc/security/time.conf si no existia previamente
   if [[ ! -x /etc/security/time.conf.bkp ]]
   then
      cp /etc/security/time.conf /etc/security/time.conf.bkp
   fi
   # usu1 y usu2 pueden logearse por cualquier tty entre las 9:00 y las 15:00 independientemente del dia
   echo "login;tty*;usu1|usu2;Al0900-1500" >> /etc/security/time.conf
   # usu3 puede logearse por cualquier tty de lunes a jueves entre las 16:00 y las 21:00
   echo "login;tty*;usu3;FrWk1600-2100" >> /etc/security/time.conf
   # usu5 solo puede logearse por la tty5 los dias laborables entre las 9:00 y las 15:00
   # (En dos pasos, no esta muy claro el por que)
   echo "login;!tty5;usu5;*" >> /etc/security/time.conf
   echo "login;tty*;usu5;Wk0900-1500*" >> /etc/security/time.conf
}

# --------------------------------------------------------------------------------
# MAIN: Punto de entrada del script
# --------------------------------------------------------------------------------

# PASO 1: Crear los nuevos grupos. uno para cada proyecto y otro para los ejecutivos
echo "[+] Creando grupos necesarios para los proyectos y ejecutivos..."
groupadd aeropuerto
groupadd cc
groupadd parque
groupadd ejecutivos

# PASO 2: Crear los directorios necesarios de los proyectos, y asignarle el grupo
#         primario correspondiente a los mismos
# Opciones de mkdir:
#   -v => Modo verbose (muestra un mensaje por pantalla por cada directorio creado)
#   -p => Crea directorios padres si son necesarios (evita un 'mkdir /home/proyectos')
#   -m XXXX => Establece los permisos especificados en el nuevo directorio, estilo chmod
echo "[+] Creando directorios de proyectos..."
mkdir -v -p -m 2770 /home/proyectos/aeropuerto
chgrp aeropuerto /home/proyectos/aeropuerto

mkdir -v -p -m 2770 /home/proyectos/cc
chgrp cc /home/proyectos/cc

mkdir -v -p -m 2770 /home/proyectos/parque
chgrp parque /home/proyectos/parque

mkdir -v -p -m 1777 /home/proyectos/comun

# PASO 3: Llamar a la funcion 'set_fstab' para permitir cuotas y ACL's en el sistema
echo "[+] Comprobando fichero /etc/fstab y ajustando parametros necesarios..."
set_fstab

# PASO 4: Establecer las ACL para adecuar los accesos a cada proyecto, de forma que cada
#         nuevo fichero creado por un usuario del proyecto pueda ser automaticamente leido,
#         modificado o borrado (esto ultimo mediante UGO) por otro usuario del mismo proyecto
echo "[+] Estableciendo ACL's de proyectos"
setfacl -d -m g:aeropuerto:rw /home/proyectos/aeropuerto
setfacl -d -m g:cc:rw /home/proyectos/cc
setfacl -d -m g:parque:rw /home/proyectos/parque
# En el caso de '/home/proyectos/comun', se desea que este misma propiedad la tengan todos
setfacl -d -m o::rw /home/proyectos/comun

# PASO 5: Crear los usuarios y ejecutivos del sistema
echo "[+] Creando usuarios y ejecutivos..."
create_user usu1 cc
create_user usu2 aeropuerto
create_user usu3 aeropuerto,cc
create_user usu4 aeropuerto,cc
create_user usu5 aeropuerto,cc,parque
create_user usu6 parque
# Notese que a los ejecutivos se les agrega al grupo destinado a tal fin, 
# relacionado con el uso de los ejecutables 'ls<proyecto>'
create_user ejec1 ejecutivos
create_user ejec2 ejecutivos

# PASO 6: Permisos de solo lectura para los ejecutivos, de forma que no puedan
#         modificar ni borrar archivos de los proyectos a los que pertenecen
echo "[+] Estableciendo ACL's de ejecutivos..."
setfacl -d -m u:ejec1:rx /home/proyectos/aeropuerto
setfacl -d -m u:ejec1:rx /home/proyectos/parque
setfacl -d -m u:ejec2:rx /home/proyectos/aeropuerto
setfacl -d -m u:ejec2:rx /home/proyectos/cc

# PASO 7: Crear los ficheros ejecutables 'ls<proyecto>' para los ejecutivos
echo "[+] Creando programas para ejecutivos..."
create_ls aeropuerto
create_ls cc
create_ls parque

# PASO 8: [Opcional] Establecer las restricciones de acceso mediante PAM login
echo "[+] Estableciendo restricciones PAM..."
set_pam
