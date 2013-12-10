# Archive Spider v1.1 

Archive Spider is a customizable web crawler that
archives the pulled data into a tarball.

Currently the spider goes to a target index and
pulls what it reads as links. At this point it
will ask if you want to spider the links. You can
spider the links which will return a new list of links.
You then have the option to spider those as well. 
Then the script archives the session.

Set up your work directory:

sudo bash ./setup.sh

Use the spider:

bash ./archive-spider.sh

If wget hangs on a request, you can kill off the hung wget and Archive Spider
will continue on. 

kill -9 wgetpidgoeshere

You can also edit the target link files while Archive Spider is running to 
add, delete, or correct links.

vim /home/yourusernamehere/archive-spider/runnamehere/spidered-urls.out
