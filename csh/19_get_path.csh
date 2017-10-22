#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--dop]"
   exit -1
endif

if ($1 == "--dop") then
   set dop_mode=1
   shift argv
endif
if ($?dop_mode) then
   echo $DOP_HOME
else
   echo $DVC_HOME
endif
