#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/12_get_version.csh
source $DVC_CSH/15_get_container.csh

if {(test -d $DVC_CONTAINER)} then
   ( \
   cd $DVC_CONTAINER; \
   svn remove --quiet --force `glob *` ; \
   svn commit --quiet . -m "Empty all data in the version"; \
   svn update --quiet . ; \
   )
else
   echo "ERROR: Cannot find Container : $DVC_CONTAINER"
endif
