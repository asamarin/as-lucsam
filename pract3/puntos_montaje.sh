
mkdir -p /import/casa
mkdir -p /import/casa/irene
chmod 0770 /import/casa/irene
chgrp 516 /import/casa/irene
mkdir -p /import/casa/clara
chmod 0770 /import/casa/clara
chgrp 518 /import/casa/clara
mkdir -p /import/casa/laura
chmod 0770 /import/casa/laura
chgrp 517 /import/casa/laura

mkdir -p -m 0755 /import/comun
mkdir -p -m 0755 /import/proyectos
mkdir -m 2770 /import/proyectos/videojuegos
chgrp 514 /import/proyectos/videojuegos
mkdir -m 2770 /import/proyectos/portales
chgrp 515 /import/proyectos/portales
