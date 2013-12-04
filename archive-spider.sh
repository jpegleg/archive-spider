#!/usr/bin/bash
# Gather and archive web data.

echo "Type the name of the spider user (your username) and hit enter."
read USER
WORKDIR="/home/"$USER"/archive-spider"

# echo "Would you like to archive this session?";
# echo "Please type yes or no then hit enter.";
# read OPTARCHIVE
# if [[ "$OPTARCHIVE" == "yes" ]]; then
#    archiveon
# else if [["$OPTARCHIVE" == "no" ]]; then
#    archiveoff
# else
#   echo "Please use yes or no."
# fi

# Now lets point the spider.
echo "What is the point of origin for this run?";
echo "Enter the full url please.";
read URL
echo "Running spider...";

RUNSTAMP=$(date | cut -c1-3,5-7,10,12,13,15,16,18,19,25-28)
mkdir "$WORKDIR"/"$RUNSTAMP";
RUNDIR="$WORKDIR"/"$RUNSTAMP";
wget -P "$RUNDIR"/ "$URL";
echo "$URL index is now in $RUNDIR";
echo "Starting analysis.";
function urlextract {
grep -io '<a href=['"'"'"][^"'"'"']*['"'"'"]' /home/"$USER"/archive-spider/"$RUNSTAMP"/* |  sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'| cut -d ":" -f2-99 | cut -d "\"" -f2 | sort -u;
};
urlextract >> "$RUNDIR"/index-urls.out;
echo "Index URLS:";
cat "$RUNDIR"/index-urls.out;
echo "Shall we spider the links?"
echo "Type yes or no and hit enter please.";
read SPIDERON
function spiderdeeper {
    while read z; do
        wget -P "$RUNDIR"/ "$z";
        echo "$z";
    done<"$RUNDIR"/index-urls.out;
};
if [[ "$SPIDERON" == "yes" ]]; then
    spiderdeeper
else
    echo "Okay, stopping."
fi
echo "Starting analysis.";
urlextract >> "$RUNDIR"/spidered-urls.out;
cat "$RUNDIR"/spidered-urls.out;
echo "Would you like to spider deeper?"
echo "Please enter yes or no."
read SPIDERON2
function spiderdeeper2 {
while read z; do
        wget -P "$RUNDIR"/ "$z";
        echo "$z";
    done<"$RUNDIR"/spidered-urls.out;
};
if [[ "$SPIDERON2" == "yes" ]]; then
    spiderdeeper2
else
   echo "Okay, stopping."
fi
echo "Archiving session."
tar czvf "$RUNSTAMP".tar.gz "$RUNDIR";
echo "Cleaning up."
rm -rf "$RUNDIR";
mv "$RUNSTAMP".tar.gz "$WORKDIR"/"$RUNSTAMP".tar.gz;
