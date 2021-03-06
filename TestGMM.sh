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

# This is the acoustic model to use
acousticModel=../plp
languageModel=../iss-wsj/wsj5k
export DECODE_ACOUSTIC_MODEL_DIR=$acousticModel/hmm-eval
export DECODE_LANGUAGE_MODEL_DIR=$languageModel/htk-lm

# The other things depend on which decoder is used
export DECODER=HDecode
case $DECODER in
'HVite')
    export DECODE_LM_SCALE=16.0
    export DECODE_WORD_PENALTY=-10.0
    export PRUNE="300 300 5000"
    ;;
'HDecode')
    # HDecode should be a 32 bit version, so override it.
    export HDECODE=/idiap/resource/software/HTK/HTK_V3.4.1/bin/HDecode
    export DECODE_LM_SCALE=16.0
    export DECODE_WORD_PENALTY=-10.0
    export PRUNE="250.0 250.0"
    export DECODE_BLOCK_SIZE=5
    ;;
'Juicer')
    export FEAT_NAME=PLP_0_D_A_Z
    export WFST_LG_DIR=$languageModel/wfst-lg
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
