#!/bin/bash

for i in `seq 1 6`
do
   userdel -rf usu$i
done

for i in `seq 1 2`
do
   userdel -rf ejec$i
done

rm -rf /home/proyectos
groupdel aeropuerto
groupdel cc
groupdel parque

rm -f /usr/local/bin/ls*
cp /etc/fstab.bkp1 /etc/fstab

cp /etc/pam.d/login.bkp /etc/pam.d/login
cp /etc/security/time.conf.bkp /etc/security/time.conf
