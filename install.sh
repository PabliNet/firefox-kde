#!/bin/bash
[ `whoami` == root ] || echo Se necesita ser superusuario o root…
[ ! -f $1 ] || echo El archivo no existe.
newdir=/opt/firefox
newlink=/usr/local/bin/firefox
newscript=/usr/local/bin/firefox-kde
case $# in
  1)
  user=`awk -F':' '{if ($3=="1000") {print $1}}' /etc/passwd`
  tar -xf $1 -C /opt
  ln -s $newdir/firefox $newlink
  echo -e \#\!/bin/bash\\nGTK_USE_PORTAL=1 firefox \$1 > $newscript
  chmod +x $newscript
  cp -i firefox.png /usr/share/pixmaps
  cp -i firefox.desktop /usr/share/applications
  chown -R $user:$user $newdir
;;
  *)
  echo Error: Solo tiene que agregar el nombre del archivo.
;; esac
