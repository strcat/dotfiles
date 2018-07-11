#!/bin/sh
#
# Copyright by Christian Schneider <strcat@gmx.net>
#
# $Id: kill-from.sh,v 1.1 2003/09/11 16:17:21 dope Exp dope $
#
# Last modified: [ 2003-09-11 18:16:09 ]
#
# Extract only the address from the *first* 'From:' - Header. 
# This oneliner parse 
#  | From: Name Vorname <name@domain.tdl>
#  | From: Name Vorname [name@domain.tdl]
#  | From: Name [ name@domain.tdl ] Vorname
#  | From: <name@domain.tdl> Name Vorname
#  | From: Name \"Evil himself\" Vorname <name@domain.tdl>
# correctly. 
# A alternative is this little script:
#  | sed -n '
#  | [a-zA-Z0-9_.-]\{1,\}@[a-zA-Z0-9-]\{1,\}\(\.[a-zA-Z0-9-]\{1,\}\)\{1,2\}/{
#  |   s//\
#  | &\
#  | /;s/.*\n\(.*\n\)/\1/;P;D;}'
# Hint: that '_' are not supposed to be part of domain names. 
# Note: '|head -n 1' *is* important!

DIE=`grep -i "^From:" | sed 's/ *(.*)//; s/>.*//; s/.*[:<] *//; s/.*[\[] *//; s/].*//; s/.*[\{] *//; s/}.*//; s/\"//g' | head -n 1`
echo "DENY=^From:.*$DIE" >> /home/dope/.mailfilter/deny-from
