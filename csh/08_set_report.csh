#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--html <dir>]"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/
endif
setenv CSH_DIR $DVC_HOME/csh 
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/18_get_report.csh
source $CSH_DIR/04_set_design.csh

endif


