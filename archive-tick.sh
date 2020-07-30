#!/usr/bin/env bash

#################################################################
#                                                               #
#  Download all files from a site that has directory browsing   #
#                                                               #
#                                                               #
#################################################################

tick () {
  wget --limit-rate=800k $1
  grep -o href..* index.html | cut -d '"' -f2 > ticker.index
  cat ticker.index | while read line; do
    echo "$1"/$line
    wget "$1"/$line
  done
}

recurse () {
  for deeper in $(ls index.html*); do
    secondex=$(grep -o "Index of.*" "$deeper" | cut -d'<' -f1 | cut -d' ' -f3 | head -n1)
    grep -o href..* "$deeper" | cut -d '"' -f2 > ticker.index
    cat ticker.index | while read line; do
        echo "$globtick"/"$secondex"/"$line"
        wget --limit-rate=800k "$globtick"/"$secondex"/"$line"
    done
  done
}

mkdir tick-workspace
cd tick-workspace
tick $1
export globtick=$(echo $1 | cut -d'/' -f1-3)
mv index.html original.index
recurse # if the directories are more than two layers deep, you could add an additional recurse for each additional layer
# although adding more instances of recurse will create file download duplication
tar czvf archive-tick_$(date +%Y%m%d%H%M%S%N).tgz ./*
cd ..
