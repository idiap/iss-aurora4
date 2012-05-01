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
export DECODE_DICT=$MAIN_DICT

# This is the acoustic model to use
acousticModel=../plp
export DECODE_MODEL_DIR=$acousticModel/hmm-eval

# The other things depend on which decoder is used
export DECODER=HDecode
case $DECODER in
'HVite')
    export DECODE_NETWORK=../iss-wsj/wsj5k/network.txt
    export DECODE_LM_SCALE=16.0
    export DECODE_WORD_PENALTY=-10.0
    export PRUNE="300 300 5000"
    ;;
'HDecode')
    export HDECODE=/idiap/resource/software/HTK/HTK_V3.4.1/bin/HDecode
    export NET_LM=../iss-wsj/local/bcb05cnp-arpa.txt
    export NET_WORDS=../iss-wsj/local/wlist5c-nvp.txt
    export DECODE_DICT=../iss-wsj/wsj5k/rec-dict.txt
    export DECODE_LM_SCALE=16.0
    export DECODE_WORD_PENALTY=-10.0
    export PRUNE="250.0 250.0"
    export DECODE_BLOCK_SIZE=5
    ;;
'Juicer')
    export FEAT_NAME=PLP_0_D_A_Z
    export WFST_LG_DIR=../iss-wsj/wsj5k/wfst-lg
    export WFST_CLG_DIR=$acousticModel/wfst-clg-wsj5k
    export Tracter_Verbose=1
    export DECODE_BEAM="400.0 400.0 400.0"
    ;;
esac

# There are potentially lots of test lists for Aurora 4
for list in {01..14}
do
    export FILE_LIST=../local/test${list}_0166_16k.list
    export DECODE_LIST=decode-list-$list.txt
    export DECODE_MLF=decode-$list.mlf

    # Run the decode
    decode.sh

    # Different tasks are independent
    rm -f job-file
done
