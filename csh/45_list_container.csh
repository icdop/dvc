#!/bin/csh -f
#set verbose=1
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
source $CSH_DIR/14_get_design.csh
source $CSH_DIR/05_set_container.csh

# Use "source list_dvc_path.csh" and specify DESIGN_URL 
# is to preserve option modes and pass them to list_dvc_path.csh
if {(test -d $CONTAINER_DIR)} then
   setenv DESIGN_URL $SVN_URL/$DESIGN_PROJT/$CONTAINER_PATH
   source $CSH_DIR/49_list_dvc_path.csh
else
   echo "ERROR: Can not find Container Directory: $CONTAINER_DIR"
endif
 