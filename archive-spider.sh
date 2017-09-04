#!/usr/bin/env bash

#-----------------> Interactively gather and archive web data.

######################################################################
####################-----------> Thread spiders by user.##############

WORKDIR="$HOME/archive-spider"

# Now lets point the spider.
echo "What is the point of origin for this run?";
echo "Enter the full url please.";
read URL
echo "Running spider...";

# Set a function to archive the session.
archives() {
  echo "Archiving session."
  tar czvf "$RUNSTAMP".tar.gz "$RUNDIR";
  echo "Cleaning up."
  rm -rf "$RUNDIR";
  mv "$RUNSTAMP".tar.gz "$WORKDIR"/"$RUNSTAMP".$(echo $URL | tr -cd '[[:alnum:]]._-').tar.gz;
}
# Non-elegant timestamp... don't ask. 
RUNSTAMP=$(date "+%m-%d-%Y-%H%M-%S")
mkdir "$WORKDIR"/"$RUNSTAMP";
RUNDIR="$WORKDIR"/"$RUNSTAMP";

# This spider-scrapper uses wget to fetch data.
wget -P "$RUNDIR"/ "$URL";

echo "$URL index is now in $RUNDIR";
echo "Starting analysis.";

# This is a sequential iteration though files using a regex
# that grabs strings that look like urls, via href attributes.
urlextract() {
  for link in $(ls $RUNDIR/* ) ; do
    cp "$link" /home/$USER/archive-spider/tmp/index.html
    cd /home/$USER/archive-spider/tmp/
    /usr/local/scripts/netstew.py
  done
};
# Pull out the urls and dump them to a file.
urlextract >> "$RUNDIR"/index-urls.out;

echo "Index URLS:";
cat "$RUNDIR"/index-urls.out;
echo "Shall we spider the links?"
echo "Type yes or no and hit enter please.";
# Loop through the extracted urls, this is where it gets most interesting.
read SPIDERON
spiderdeeper() {
  while read z; do
    wget -P "$RUNDIR"/ "$z";
    echo "$z";
  done<"$RUNDIR"/index-urls.out;
};
if [[ "$SPIDERON" == "yes" ]]; then
  spiderdeeper
else
  echo "Okay, stopping."
  archives
  exit 1
  fi

# To keep things under control, we have a limited
# step loop with a user prompt. Now we ask for
# further spidering then loop through the data again.
echo "Starting analysis.";
urlextract >> "$RUNDIR"/spidered-urls.out;
cat "$RUNDIR"/spidered-urls.out;
echo "Would you like to spider deeper?"
echo "Please enter yes or no."

read SPIDERON2
spiderdeeper2() {
while read z; do
  wget -P "$RUNDIR"/ "$z";
  echo "$z";
  done<"$RUNDIR"/spidered-urls.out;
};

# After this we stop for the run. This is enough
# for the purposes of this script. You can easily
# expand the depth of the run by duplicating
# the segment above and write a spiderdeeper3 or
# simply by running further instances of spiderdeeper
# and spiderdeeper2 as you can imagine.

if [[ "$SPIDERON2" == "yes" ]]; then
  spiderdeeper2
else
  echo "Okay, stopping."
  archives
  exit 1
fi

archives;
