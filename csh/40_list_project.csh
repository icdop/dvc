#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh

if ($1 != "") then
   if (($1 != "_") && ($1 != ".")) then
   setenv DESIGN_PROJT $1
   shift argv
   endif
endif

# Use "source list_design_path.csh" and specify DESIGN_URL 
# is to preserve option modes and pass them to list_design_path.csh
setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv DESIGN_URL $PROJT_URL
source $CSH_DIR/49_list_design_path.csh

exit 0
