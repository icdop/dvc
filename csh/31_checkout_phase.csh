#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PHASE>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   setenv DESIGN_PHASE $1
   $CSH_DIR/00_set_env.csh DESIGN_PHASE $DESIGN_PHASE
   shift argv
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
svn info $PHASE_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Phase : $DESIGN_PHASE"
   exit 1
endif

echo "INFO: Checkout Project Design Phase : $DESIGN_PHASE"

mkdir -p $CURR_PROJT/$DESIGN_PHASE

if ($?depth_mode) then
   svn checkout --quiet --force $PHASE_URL $CURR_PROJT/$DESIGN_PHASE --depth $depth_mode
#   svn update --quiet --force $CURR_PROJT/DESIGN_PHASE
endif

if {(test -e $CURR_PROJT/$DESIGN_PHASE/.dvc)} then
   svn update --quiet --force $CURR_PROJT/$DESIGN_PHASE/.dvc
else
   svn checkout --force $PHASE_URL/.dvc $CURR_PROJT/$DESIGN_PHASE/.dvc
endif

rm -f $CURR_PROJT/:
ln -s $DESIGN_PHASE $CURR_PROJT/:

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
