#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [-v] <variable>"
   exit -1
endif
if (($1 == "-v") || ($1 == "--verbose")) then
   set verbose = 1
   shift argv
endif
if ($1 == "--pvar") then
   set pvar = 1
   shift argv
else
   set pvar = 0
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
if ( $pvar == 1) then
   echo "DVC_CSH      = $DVC_CSH"
endif

