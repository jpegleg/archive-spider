#!/usr/bin/env bash
echo "What is your username?";
read SETUPUSER

mkdir /home/"$SETUPUSER"/archive-spider
mkdir /home/"$SETUPUSER"/tmp

echo "Now installing netstew.py to /usr/local/scripts"
mkdir -p /usr/local/scripts
cp ./netstew.py /usr/local/scripts/netstew.py

echo "Now installing archive-spider to /usr/local/bin/archive-spider"
cp ./archive-spider.sh /usr/local/bin/archive-spider
chmod +x /usr/local/bin/archive-spider
