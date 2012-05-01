#!/bin/zsh
#
# Copyright 2012 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, April 2012
#
echo Script: $0
source Config.sh
chdir.sh $*

# There are potentially lots of test lists for Aurora 4
for list in {01..14}
do
    # Different tasks are independent.
    # Start immediately, but leave a job-file for the next script.
    rm -f job-file

    export FILE_LIST=../local/test${list}_0166_16k.list
    export EXTRACT_LIST=extract-list-$list.txt
    extract.sh
done
