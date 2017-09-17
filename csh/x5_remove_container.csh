#!/bin/csh -f
#set verbose=1
set prog=$0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
source $DVC_HOME/csh/12_get_server.csh
source $DVC_HOME/csh/13_get_project.csh
source $DVC_HOME/csh/14_get_version.csh
source $DVC_HOME/csh/05_set_container.csh

if {((test -d $CONTAINER_DIR)&&(test -d $CURR_PROJT/$DVC_PATH))} then
   echo "INFO: Remove Project Design Container '$DVC_PATH'."
   rm -fr $CURR_PROJT/$DVC_PATH
   svn remove $SVN_URL/$DESIGN_PROJT/$DVC_PATH -m "Remove Design Container"
#   rm -fr $CURR_CONTR
else
   echo "ERROR: Can not remove Design Container '$CONTAINER_DIR'!"
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
