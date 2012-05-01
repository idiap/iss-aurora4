#!/bin/zsh
#
# Copyright 2012 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, April 2012
#
source Config.sh
chdir.sh local

listDir=../dbase/lists
lists=( $(cd $listDir; ls *.list) )

for l in $lists
do
    cat $listDir/$l \
        | sed s/.wv.$// \
        > $l
done
