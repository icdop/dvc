#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DVC_PATH>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/
endif
setenv CSH_DIR $DVC_HOME/csh 
source $CSH_DIR/14_get_version.csh

if ($1 == "--no_curr_link") then
   set no_curr_link=1
   shift argv
endif

set dvc_path = $1
if ($dvc_path != "") then
   set version  = $dvc_path:t
   if ($dvc_path != $version) then
      set dvc_path = $dvc_path:h
      set stage = $dvc_path:t
      if ($dvc_path != $stage) then
         set dvc_path = $dvc_path:h
         set block    = $dvc_path:t
         if ($dvc_path != $block) then
            set dvc_path = $dvc_path:h
            set phase    = $dvc_path:t
         else
            set phase = ""
         endif
      else
         set block = ""
         set phase = ""
      endif
   else
      set stage = ""
      set block = ""
      set phase = ""
   endif
else
   set version = ""
   set stage = ""
   set block = ""
   set phase = ""
endif

if (($?phase != 0) && ($phase != "") && ($phase != ":") && ($phase != ".")) then
    setenv DESIGN_PHASE $phase
    $CSH_DIR/00_set_env.csh --quiet DESIGN_PHASE $DESIGN_PHASE
endif

if (($?block != 0) && ($block != "") && ($block != ":") && ($block != ".")) then
    setenv DESIGN_BLOCK $block
    $CSH_DIR/00_set_env.csh --quiet DESIGN_BLOCK $DESIGN_BLOCK
endif

if (($?stage != 0) && ($stage != "") && ($stage != ":") && ($stage != ".")) then
    setenv DESIGN_STAGE $stage
    $CSH_DIR/00_set_env.csh --quiet DESIGN_STAGE $DESIGN_STAGE
endif

if (($?version != 0) && ($version != "") && ($version != ":") && ($version != ".")) then
    setenv DESIGN_VERSN $version
    $CSH_DIR/00_set_env.csh --quiet DESIGN_VERSN $DESIGN_VERSN
endif

if ($?no_curr_link == 0) then
    if {(test -h $CURR_PHASE)} then
       rm -f $CURR_PHASE
    else if {(test -d $CURR_PHASE)} then
       echo "ERROR: $CURR_PHASE is a folder, rename it!"
       mv $CURR_PHASE phase.`date +%Y%m%d_%H%M%S`
    endif
    ln -fs $CURR_PROJT/$DESIGN_PHASE $CURR_PHASE

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
endif

echo "==============================="
echo "DESIGN_PROJT = $DESIGN_PROJT"
echo "-------------------------------"
echo "DESIGN_PHASE = $DESIGN_PHASE"
echo "DESIGN_BLOCK = $DESIGN_BLOCK"
echo "DESIGN_STAGE = $DESIGN_STAGE"
echo "DESIGN_VERSN = $DESIGN_VERSN"
echo "==============================="
