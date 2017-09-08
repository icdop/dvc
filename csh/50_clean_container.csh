#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh
source $CSH_DIR/15_get_container.csh

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
