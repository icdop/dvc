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
source $CSH_DIR/14_get_design.csh

if ($1 != "") then 
   set dvc_path = $1
   shift argv
endif

if ($?dvc_path != 0) then
   # check if dvc_path contain is tailing /
   if ($dvc_path:t == "") then 
      set dvc_path = $dvc_path:h
   endif
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
            set phase = ":"
         endif
      else
         set block = ":"
         set phase = ":"
      endif
   else
      set stage = ":"
      set block = ":"
      set phase = ":"
   endif
else
   set phase   = $DESIGN_PHASE
   set block   = $DESIGN_BLOCK
   set stage   = $DESIGN_STAGE
   set version = $DESIGN_VERSN
endif

if ($?verbose_mode) then
echo "==============================="
echo "DESIGN_PHASE = $phase"
echo "DESIGN_BLOCK = $block"
echo "DESIGN_STAGE = $stage"
echo "DESIGN_VERSN = $version"
echo "==============================="
endif

exit 0


