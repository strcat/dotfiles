#!/bin/sh
#
# Copyright by Christian Schneider <strcat@gmx.net>
#
# $Id: gpg-wrap.sh,v 1.1 2003/10/05 16:57:57 dope Exp dope $
#
# Filename       : ~/bin/gpg-wrap.sh
# Purpose        : Blind out this fucking GPG-strings (use it with Mutt)
# Author         : Christian Schneider <strcat@gmx.net>
# Latest release : <http://strcat.neessen.net/>
#
# Last modified: [ 2003-12-23 02:02:54 ]
sed -n '/\[--.*PGP output follows.*--\]/,/\[--.*End of PGP output.*--\]/!p'
