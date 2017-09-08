#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PHASE>"
   exit -1
endif
if ($1 == "--verbose") then
   set verbose_mode = 1
   shift argv
else if ($?verbose_mode == 0) then 
   set verbose_mode = 0
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if (($1 != "") && ($1 != ".")) then
   setenv DESIGN_PHASE $1
   echo "PARM: DESIGN_PHASE = $DESIGN_PHASE"
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE

setenv DESIGN_URL $PHASE_URL
source $CSH_DIR/49_list_design.csh

exit 0
