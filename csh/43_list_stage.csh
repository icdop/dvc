#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_STAGE>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if ($1 != "") then
   if (($1 != ":") && ($1 != ".")) then
   setenv DESIGN_STAGE $1
   shift argv
   endif
endif

# Use "source list_dir.csh" and specify DESIGN_URL 
# is to preserve option modes and pass them to list_dir.csh
setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE

setenv DESIGN_URL $STAGE_URL
source $CSH_DIR/49_list_dir.csh

exit 0
