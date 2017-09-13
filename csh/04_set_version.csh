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
endif

if (($2 != "") && ($2 != ":") && ($2 != ".")) then
    setenv DESIGN_STAGE $2
    echo $DESIGN_STAGE > .dop/env/DESIGN_STAGE
    echo "SETP: DESIGN_STAGE = $DESIGN_STAGE"
endif

if (($3 != "") && ($3 != ":") && ($3 != ".")) then
    setenv DESIGN_BLOCK $3
    echo $DESIGN_BLOCK > .dop/env/DESIGN_BLOCK
    echo "SETP: DESIGN_BLOCK = $DESIGN_BLOCK"
endif
            
if (($4 != "") && ($4 != ":") && ($4 != ".")) then
    setenv DESIGN_PHASE $4
    echo $DESIGN_PHASE > .dop/env/DESIGN_PHASE
    echo "SETP: DESIGN_PHASE = $DESIGN_PHASE"
    if {(test -h $CURR_PHASE)} then
       rm -f $CURR_PHASE
    else if {(test -d $CURR_PHASE)} then
       echo "ERROR: $CURR_PHASE is a folder, rename it!"
       mv $CURR_PHASE phase.`date +%Y%m%d_%H%M%S`
    endif
    ln -fs $CURR_PROJT/$DESIGN_PHASE $CURR_PHASE
endif

if {(test -h $CURR_BLOCK)} then
   rm -f $CURR_BLOCK
else if {(test -d $CURR_BLOCK)} then
   echo "ERROR: $CURR_BLOCK is a folder, rename it!"
   mv $CURR_BLOCK block.`date +%Y%m%d_%H%M%S`
endif
ln -fs $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK $CURR_BLOCK

if {(test -h $CURR_STAGE)} then
   rm -f $CURR_STAGE
else if {(test -d $CURR_STAGE)} then
   echo "ERROR: $CURR_STAGE is a folder, rename it!"
   mv $CURR_STAGE stage.`date +%Y%m%d_%H%M%S`
endif
ln -fs $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE $CURR_STAGE

if {(test -h $CURR_VERSN)} then
   rm -f $CURR_VERSN
else if {(test -d $CURR_VERSN)} then
   echo "ERROR: $CURR_VERSN is a folder, rename it!"
   mv $CURR_VERSN version.`date +%Y%m%d_%H%M%S`
endif
ln -fs $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN $CURR_VERSN

echo "==============================="
echo "DESIGN_PROJT = $DESIGN_PROJT"
echo "-------------------------------"
echo "DESIGN_PHASE = $DESIGN_PHASE"
echo "DESIGN_BLOCK = $DESIGN_BLOCK"
echo "DESIGN_STAGE = $DESIGN_STAGE"
echo "DESIGN_VERSN = $DESIGN_VERSN"
echo "==============================="
