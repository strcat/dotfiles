# $Id: .xinitrc,v 1.19 1994/10/04 04:30:06 dope Exp dope $
#
# Author      : Christian Schneider <strcat@gmx.net>
# Filename    : ~/.xinitrc
# Description : This file manage the client programs during a start of the
#               X Window System.
# Note        : This file should be renamed ".xinitrc" or ".xsession"
#               and placed in your home directory. Which name you give
#               it depends on your system, generally .xinit is for use
#               with the "startx" command the .xsession for graphical
#               logins.
# Tip         : You should be able to find most of the programs
#               mentioned here on http://www.freshmeat.net/ - if you
#               can't please contact me. Also contact me if you make use
#               of this file, it would be nice to know that putting it
#               online wasn't a complete waste of time.
# Structure of this file:
#               "#" means a line is a comment and the system will ignore
#               it! If a line is comment out, it is either a genuine
#               comment, or a command that is no longer used (either
#               becuase I don't want the feature any more or becuase
#               another line duplicates that feature).

# The preferred window manager
# WINDOWMANAGER='wmi'
# WINDOWMANAGER='leftwm'
# WINDOWMANAGER="bspwm"
# WINDOWMANAGER="i3"
WINDOWMANAGER="~/.config/dwm/dwm/dwm"

# Load Users X11 resource database
if test -f $HOME/.Xresources ; then
	xrdb ~/.Xresources
fi

# My own keymap (Umlauts, Euro-/Cent-Symbol, ..)
# <http://www.strcat.de/blog/sonderzeichen-mit-us-layout-eingeben.html>
setxkbmap us_de

# caps lock to backspace
setxkbmap -option caps:escape

# Clipboardmanager (<https://github.com/cdown/clipmenu>)
clipmenud &

# xrandr
~/bin/monitorlayout.sh &

# Disable display power management and prevent screen from blanking (monitor is
# turned on but with a black image); check with "xset q"
xset s off -dpms

# Start the window manager...
exec $WINDOWMANAGER
