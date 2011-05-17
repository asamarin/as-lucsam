#!/bin/bash

#function create_user {
#   useradd -m -d /import/casa/$1 -U -s /bin/bash -G $2 $1

   # Cambiar la passwohrd del nuevo usuario (igual que su username)
#   echo $1:$1 | chpasswd

   # Root sera el propietario de su directorio de conexion, para que el 
   # usuario no pueda modificar los permisos del mismo
#   chown root /export/casa/$1

   # Estableciendo permisos "rwxrwx---" se asegura que el usuario
   # puede crear, modificar y borrar ficheros y directorios en su 
   # 'home', a la vez que se previene que otros usuarios puedan acceder
#   chmod 770 /export/casa/$1
#}

#groupadd videojuegos
#groupadd portales

mkdir -p /export/casa
mkdir -p /export/casa/irene
chmod 0770 /export/casa/irene
chgrp 516 /export/casa/irene
mkdir -p /export/casa/clara
chmod 0770 /export/casa/clara
chgrp 518 /export/casa/clara
mkdir -p /export/casa/laura
chmod 0770 /export/casa/laura
chgrp 517 /export/casa/laura

mkdir -p -m 0755 /export/comun
mkdir -p -m 0755 /export/proyectos
mkdir -m 2770 /export/proyectos/videojuegos
chgrp 514 /export/proyectos/videojuegos
mkdir -m 2770 /export/proyectos/portales
chgrp 515 /export/proyectos/portales

setfacl -d -m g:514:rwx /export/proyectos/videojuegos
setfacl -d -m g:515:rwx /export/proyectos/portales

#create_user irene videojuegos
#create_user laura portales
#create_user clara videojuegos,portales
