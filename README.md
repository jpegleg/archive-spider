# Archive Spider v1.2 

Archive Spider is a customizable web crawler that
archives the pulled data into a tarball.

Currently the spider goes to a target index and
pulls what it reads as links. At this point it
will ask if you want to spider the links. You can
spider the links which will return a new list of links.
You then have the option to spider those as well. 
Then the script archives the session.

Version 1.1 was entirely shell with a nasty regular expression for link extraction. Version 1.1 may have been very portable, but 1.2 has much better link extraction using python BeautifulSoup. Version 1.2 uses a code snippet I call netstew.py to pull the links. Here is the snippet:

#################################################

from bs4 import BeautifulSoup

soup = BeautifulSoup(open("index.html"))

for link in soup.find_all('a'):
    print(link.get('href'))

#################################################

Link to git repo of netstew.py:
https://github.com/jpegleg/netstew

Archive Spider 1.2 iterates through the web content with the above and downloads those links, then iterates through the those links. It is not set to go infinite, nobody wants that. Instead it has a max 3 depth, controlled interactively.

Alright, lets get things setup. Get your BeautifulSoup installed where your /usr/local/scripts/netstew.py can find it.
Then place your files, including the netstew.py you want to deploy in your pwd and set up your work directory:

sudo bash ./setup.sh

Use the spider:

archive-spider

If wget hangs on a request, you can kill off the hung wget and Archive Spider
will continue on. 

kill -9 wgetpidgoeshere

You can also edit the target link files while Archive Spider is running to 
add, delete, or change links.

vim /home/yourusernamehere/archive-spider/runnamehere/spidered-urls.out

#################################################

archive-tick.sh

This script is for targets that have directory browsing enabled. If a site has Index of thing and you can browse the file system, archive-tick.sh can download it all!

./archive-tick.sh https://someplace/somedirectorylisting/

