#!/bin/bash
cd "${0%/*}"
pwd
git pull
git merge origin/master
./compile.sh
git commit -am "update stats"
git push

s3cmd put ./statfile.stat s3://procelio/stats/prod.stat
curl -X POST https://releases.procelio.com:9630/admin/reload_stats -d "$RELOADKEY"
ssh -i ~/.ssh/acct_digitalocean root@accounts.procelio.com "tmux kill-session -t accounts; ./launch_all.sh"
