#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/03_set_project.csh

echo "PARM: PROJ_URL = $PROJT_URL"
svn info $PROJT_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Can not find Project Design Respository : $DESIGN_PROJT"
   exit 1
endif

if ($?info_mode) then
   svn info $PROJT_URL
endif

echo "INFO: Checkout Project Design Respository : $DESIGN_PROJT"
#svn auth  $PROJT_URL --username db --password dvc

mkdir -p $CURR_PROJT

if ($?depth_mode) then
   svn checkout --quiet --force $PROJT_URL $CURR_PROJT --depth $depth_mode
#   svn update --quiet --force $CURR_PROJT
endif

if {(test -e $CURR_PROJT/.dvc)} then
   svn update --quiet --force $CURR_PROJT/.dvc
else
   svn checkout --force $PROJT_URL/.dvc $CURR_PROJT/.dvc
endif


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
