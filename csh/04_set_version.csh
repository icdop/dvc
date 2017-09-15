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

if (($phase != "") && ($phase != ":") && ($phase != ".")) then
    setenv DESIGN_PHASE $phase
    $CSH_DIR/00_set_env.csh --quiet DESIGN_PHASE $DESIGN_PHASE
endif

if (($block != "") && ($block != ":") && ($block != ".")) then
    setenv DESIGN_BLOCK $block
    $CSH_DIR/00_set_env.csh --quiet DESIGN_BLOCK $DESIGN_BLOCK
endif

if (($stage != "") && ($stage != ":") && ($stage != ".")) then
    setenv DESIGN_STAGE $stage
    $CSH_DIR/00_set_env.csh --quiet DESIGN_STAGE $DESIGN_STAGE
endif

if (($version != "") && ($version != ":") && ($version != ".")) then
    setenv DESIGN_VERSN $version
    $CSH_DIR/00_set_env.csh --quiet DESIGN_VERSN $DESIGN_VERSN
endif

echo "==============================="
echo "DESIGN_PROJT = $DESIGN_PROJT"
echo "-------------------------------"
echo "DESIGN_PHASE = $DESIGN_PHASE"
echo "DESIGN_BLOCK = $DESIGN_BLOCK"
echo "DESIGN_STAGE = $DESIGN_STAGE"
echo "DESIGN_VERSN = $DESIGN_VERSN"
echo "==============================="
