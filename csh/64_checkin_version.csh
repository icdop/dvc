#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN>"
   exit 1
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

setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
if {(test -e $CURR_PROJT/$DVC_PATH/.dvc)} then
   svn update $CURR_PROJT/$DVC_PATH 
   (cd $CURR_PROJT/$DVC_PATH; svn add .  --force --depth infinity)
#   svn add $CURR_PROJT/$DVC_PATH --force --depth infinity --quiet
   svn commit $CURR_PROJT/$DVC_PATH -m 'Update version'
else
   echo "ERROR: Cannot find Version Directory '$DVC_PATH'"
   exit 1
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
