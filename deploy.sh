#!/bin/bash
if [ ! -f ./edprivate.ppk ]; then
  cp /mnt/c/Programming/Tools/SSH/edprivate.ppk .
  chmod 600 ./edprivate.ppk
fi

scp -i ./edprivate.ppk ./statfile.stat root@files.procelio.com:.
