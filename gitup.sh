#!/bin/bash

if [ ! -e /etc/systemd/system/gitup.timer ]; then

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln $DIR/systemd/gitup.* /etc/systemd/system/
systemctl daemon-reload
systemctl start gitup.timer
systemctl enable gitup.timer

fi

git add .
git commit -m "$(date) automated backup script (gitup.sh)"
git push -uf origin master;

exit 0
