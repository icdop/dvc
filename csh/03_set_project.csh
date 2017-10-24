#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/
endif
setenv CSH_DIR $DVC_HOME/csh 
source $CSH_DIR/13_get_project.csh

if ($1 == "--force") then
   set force_mode=1
   shift argv
endif

if ($1 != "") then
  if (($1 != "_") && ($1 != ".")) then
    setenv DESIGN_PROJT $1
    $CSH_DIR/00_set_env.csh DESIGN_PROJT $DESIGN_PROJT
  endif
  shift argv
endif

exit 0
