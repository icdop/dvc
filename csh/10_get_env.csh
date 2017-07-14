#!/bin/csh -f
#set verbose = 1
if (($1 == "-v") || ($1 == "--verbose")) then
   set pvar = 1
else
   set pvar = 0
endif

if ($?DOP_HOME == 0) then
   setenv DVC_BIN $0:h
else
   setenv DVC_BIN $DOP_HOME/dvc/bin
endif
if ( $pvar == 1) then
   echo "DVC_BIN      = $DVC_BIN"
endif

source $DVC_BIN/dvc_get_svn
source $DVC_BIN/dvc_get_version
