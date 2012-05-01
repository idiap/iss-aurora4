#!/bin/zsh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, July 2011
#
source Config.sh

# Variables
temp=/idiap/temp/$(whoami)/dbase/aurora4

# Links to database
ln -s $aurora4/dbase dbase
ln -s $aurora4/audio audio
ln -s ../iss-wsj iss-wsj

# Link in the temp dir
feats=$temp/feats
echo Write features to $feats
mkdir -p $feats
ln -sf $feats feats
