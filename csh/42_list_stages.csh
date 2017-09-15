#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_BLOCK>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if (($1 != "") && ($1 != ".")) then
   setenv DESIGN_BLOCK $1
   echo "PARM: DESIGN_BLOCK = $DESIGN_BLOCK"
endif

# Use "source list_dir.csh" and specify DESIGN_URL 
# is to preserve option modes and pass them to list_dir.csh
setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK

setenv DESIGN_URL $BLOCK_URL
source $CSH_DIR/49_list_dvc_path.csh

exit 0
