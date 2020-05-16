#!/usr/bin/env bash
echo "What is your username?";
read SETUPUSER

mkdir -p /home/"$SETUPUSER"/archive-spider/tmp

echo "Now installing netstew.py to /usr/local/scripts"
mkdir -p /usr/local/scripts
cp ./netstew.py /usr/local/scripts/netstew.py

echo "Now installing archive-spider to /usr/local/bin/archive-spider"
cp ./archive-spider.sh /usr/local/bin/archive-spider
chmod +x /usr/local/bin/archive-spider /usr/local/scripts/netstew.py

chown "$SETUPUSER":"$SETUPUSER" /home/"$SETUPUSER"/archive-spider/tmp /usr/local/scripts/netstew.py

echo "Install python module bs4 if you haven't. Alternatively, replace /usr/local/scripts/netstew.py with something else."
