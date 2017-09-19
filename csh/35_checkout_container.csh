#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh
source $CSH_DIR/05_set_container.csh

setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/$DESIGN_CONTR
setenv CONTR_URL $SVN_URL/$DESIGN_PROJT/$DVC_PATH
svn info $CONTR_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Cannot find container : $DVC_PATH"
   exit 1
endif

if {(test -e $CURR_PROJT/$DVC_PATH)} then
   svn update --quiet --force $CURR_PROJT/$DVC_PATH --set-depth infinity
else
   svn checkout --force $CONTR_URL $CURR_PROJT/$DVC_PATH --depth infinity
endif

if {(test -e $CURR_VERSN)} then
  rm -f $CURR_CONTR
  ln -s $CURR_VERSN/$DESIGN_CONTR $CURR_CONTR
else
  echo "ERROR: checkout version first before assigning container!" 
  exit 1
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
