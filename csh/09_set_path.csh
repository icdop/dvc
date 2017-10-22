#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--dop] <value>"
   exit -1
endif

if ($1 == "--dop") then
   set dop_mode=1
   shift argv
endif
if ($1 == "") then
   setenv DVC_HOME `realpath $0:h/..`
else
   setenv DVC_HOME $1
endif
echo "INFO: DVC_HOME = $DVC_HOME"
if ($?dop_mode) then
   setenv DOP_HOME `realpath $DVC_HOME/..`
   echo "INFO: DOP_HOME = $DOP_HOME"
endif
