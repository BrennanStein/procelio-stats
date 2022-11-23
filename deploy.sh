#!/bin/bash
cd "${0%/*}"
pwd
git pull
git merge origin/master
./compile.sh
git commit -am "update stats"
git push
scp -i ~/.ssh/digitalocean ./statfile.stat root@files.procelio.com:files/files/prod/statfile.stat

ssh -i ~/.ssh/digitalocean root@files.procelio.com "tmux kill-session -t files; tmux new-session -d -c files -s files './file-server >> log 2>&1'"

sleep 10
ssh -i ~/.ssh/acct_digitalocean root@accounts.procelio.com "tmux kill-session -t accounts; ./launch_all.sh"

