#!/bin/sh
#
# Copyright by Christian Schneider <strcat@gmx.net>
#
# $Id: kill-sub.sh,v 1.1 2003/09/11 16:17:21 dope Exp dope $
#
# Last modified: [2003-09-08 22:31:34]
SUBJECT=`grep -i ^Subject: | sed -e 's/Subject: //g' -e 's/[Rr]e: //g' | head -n 1`
echo "DENY=^Subject:.*$SUBJECT" >> /home/dope/.mailfilter/deny-subjects

