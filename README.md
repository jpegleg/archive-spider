# Archive Spider v1.0 

Archive Spider is a customizable web crawler that
archives the pulled data into a tarball.

Currently the spider goes to a target index and
pulls what it reads as links. At this point it
will ask if you want to spider the links. You can
spider the links which will return a new list of links.
You then have the option to spider those as well. 
Then the script archives the session.

Set up your work directory:

sudo bash ./setup.sh;

Use the spider:

bash ./archive-spider.sh

