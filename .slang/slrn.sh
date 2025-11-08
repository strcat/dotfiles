#!/bin/sh
rm -f ~/.nnsig
echo -e '-- ' > ~/.nnsig
echo -e 'Christian Schneider   /\|||||/\  Email: strcat@gmx.net' >> ~/.nnsig
echo -e 'http://www.strcat.de/  ( o o )   GPG-ID: 47E322CE' >> ~/.nnsig
echo -e '--------------------ooO--(_)--Ooo----------------------' >> ~/.nnsig
now-playing.sh | sed 's/^np/Now-Playing/' >> ~/.nnsig
