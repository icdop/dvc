#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN> <DESIGN_STAGE> <DESIGN_BLOCK> <DESIGN_PHASE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DVC_CSH $0:h/../csh
else
   setenv DVC_CSH $DOP_HOME/dvc/csh 
endif
source $DVC_CSH/12_get_version.csh

mkdir -p .dvc/env

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   setenv DESIGN_VERSN $1
   echo $DESIGN_VERSN > .dvc/env/DESIGN_VERSN
   echo "SETP: DESIGN_VERSN = $DESIGN_VERSN"
endif

if (($2 != "") && ($2 != ":") && ($2 != ".")) then
    setenv DESIGN_STAGE $2
    echo $DESIGN_STAGE > .dvc/env/DESIGN_STAGE
    echo "SETP: DESIGN_STAGE = $DESIGN_STAGE"
endif

if (($3 != "") && ($3 != ":") && ($3 != ".")) then
    setenv DESIGN_BLOCK $3
    echo $DESIGN_BLOCK > .dvc/env/DESIGN_BLOCK
    echo "SETP: DESIGN_BLOCK = $DESIGN_BLOCK"
endif
            
if (($4 != "") && ($4 != ":") && ($4 != ".")) then
    setenv DESIGN_PHASE $4
    echo $DESIGN_PHASE > .dvc/env/DESIGN_PHASE
    echo "SETP: DESIGN_PHASE = $DESIGN_PHASE"
endif

echo "==============================="
echo "DESIGN_PROJT = $DESIGN_PROJT"
echo "-------------------------------"
echo "DESIGN_PHASE = $DESIGN_PHASE"
echo "DESIGN_BLOCK = $DESIGN_BLOCK"
echo "DESIGN_STAGE = $DESIGN_STAGE"
echo "DESIGN_VERSN = $DESIGN_VERSN"
echo "==============================="
