#!/bin/csh -f
#set verbose = 1
if (($1 == "-v") || ($1 == "--verbose")) then
   set pvar = 1
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

source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
