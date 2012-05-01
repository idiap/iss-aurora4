#!/bin/sh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, July 2011
#

# Allow setshell
software=/idiap/resource/software
source $software/initfiles/shrc $software

# SETSHELLs
SETSHELL hts
SETSHELL grid
SETSHELL python31

# Check for ISS; add it to the path
if [ "$ISSROOT" = "" ]
then
    echo "Please \"SETSHELL iss\" or point \$ISSROOT to an ISS installation"
    exit 1
fi
path=( $ISSROOT/bin $path )
fpath=( $ISSROOT/lib/zsh $fpath )

# Functions that ISS provides
autoload chdir.sh

# Basic grid operation
nCPUs=$(cat /proc/cpuinfo | fgrep processor | wc -l)
if true
then
    export USE_GE=1
    export N_JOBS=20
else
    export USE_GE=0
    export N_JOBS=$nCPUs
fi

# Shell variables
aurora4=/idiap/resource/database/aurora4

# Environment variables to pass to working scripts
export DBASE_ROOT=..
export AUDIO_NAME=.
export PHONESET=CMUbet
export FLAT_DICT=../iss-wsj/local/flat-dict.txt
export MAIN_DICT=../iss-wsj/local/main-dict.txt

export MIX_ORDER=4

# Front-end
# $FEAT_NAME is the directory to which features are written
export EXTRACT=hcopy
export SSP_EXTRACTER=$HOME/ssp/extracter.py
feats=plp
case $feats in
user)
    export FEAT_NAME=USER
    export TARGET_KIND=USER_D_A
    ;;
mfcc)
    export FEAT_NAME=MFCC_E
    export HCOPY_CONFIG=$ISSROOT/lib/config/MFCC_E.cfg
    export TARGET_KIND=MFCC_E_D_A_Z
    ;;
plp)
    export FEAT_NAME=PLP_0
    export HCOPY_CONFIG=$ISSROOT/lib/config/PLP_0.cfg
    export TARGET_KIND=PLP_0_D_A_Z
    ;;
esac

# Train and test lists
trainList=../local/training_clean_sennh_16k.list
testList=/dev/null

# This should get overridden
export FILE_LIST=/dev/null
