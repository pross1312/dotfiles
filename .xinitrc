#!/bin/sh
# start some nice programs
fcitx5 -D &
fcitx5-remote

# load default xinit
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
