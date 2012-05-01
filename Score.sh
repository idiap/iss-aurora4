#!/bin/zsh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, July 2011
#
echo Script: $0
source Config.sh
chdir.sh $*

# Variables for the main script
export USE_GE=0
export SCORE_REFERENCE=../iss-wsj/local/si_et_05.mlf
export DECODE_DICT=$MAIN_DICT

for list in {01..14}
do
    export DECODE_MLF=decode-$list.mlf
    echo -n "$list: "
    score.sh | fgrep WORD
done
