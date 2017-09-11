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

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   setenv DESIGN_PROJT $1
   $CSH_DIR/00_set_env.csh DESIGN_PROJT $DESIGN_PROJT
   shift argv
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
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

mkdir -p .project

if ($?depth_mode) then
   svn checkout --quiet --force $PROJT_URL .project --depth $depth_mode
#   svn update --quiet --force .project
endif

if {(test -e .project/.dvc)} then
   svn update --quiet --force .project/.dvc
else
   svn checkout --force $PROJT_URL/.dvc .project/.dvc
endif


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
