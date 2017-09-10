#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN> <DESIGN_STAGE> <DESIGN_BLOCK> <DESIGN_PHASE>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/
endif
setenv CSH_DIR $DVC_HOME/csh 
source $CSH_DIR/14_get_version.csh

mkdir -p .dop/env

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
    setenv DESIGN_VERSN $1
    echo $DESIGN_VERSN > .dop/env/DESIGN_VERSN
    echo "SETP: DESIGN_VERSN = $DESIGN_VERSN"
    if {(test -h .design_versn)} then
       rm -f .design_versn
    else if {(test -d .design_versn)} then
       echo "ERROR: .design_versn is a folder, rename it!"
       mv .design_versn .design_versn.`date +%Y%m%d_%H%M%S`
    endif
    ln -fs .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN .design_versn
endif

if (($2 != "") && ($2 != ":") && ($2 != ".")) then
    setenv DESIGN_STAGE $2
    echo $DESIGN_STAGE > .dop/env/DESIGN_STAGE
    echo "SETP: DESIGN_STAGE = $DESIGN_STAGE"
    if {(test -h .design_stage)} then
       rm -f .design_stage
    else if {(test -d .design_stage)} then
       echo "ERROR: .design_stage is a folder, rename it!"
       mv .design_stage .design_stage.`date +%Y%m%d_%H%M%S`
    endif
    ln -fs .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE .design_stage
endif

if (($3 != "") && ($3 != ":") && ($3 != ".")) then
    setenv DESIGN_BLOCK $3
    echo $DESIGN_BLOCK > .dop/env/DESIGN_BLOCK
    echo "SETP: DESIGN_BLOCK = $DESIGN_BLOCK"
    if {(test -h .design_block)} then
       rm -f .design_block
    else if {(test -d .design_block)} then
       echo "ERROR: .design_block is a folder, rename it!"
       mv .design_block .design_block.`date +%Y%m%d_%H%M%S`
    endif
    ln -fs .project/$DESIGN_PHASE/$DESIGN_BLOCK .design_block
endif
            
if (($4 != "") && ($4 != ":") && ($4 != ".")) then
    setenv DESIGN_PHASE $4
    echo $DESIGN_PHASE > .dop/env/DESIGN_PHASE
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
