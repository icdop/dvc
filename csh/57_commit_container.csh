#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
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

if ($status < 0) then 
   exit $status 
endif

if {(test -d $CONTAINER_DIR)} then
   svn commit $CONTAINER_DIR -m "Commit Design Container Folder"
else
   echo "ERROR: Cannot find Container Directory '$CONTAINER_DIR'"
endif


