#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PHASE>"
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

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   setenv DESIGN_PHASE $1
   $CSH_DIR/00_set_env.csh DESIGN_PHASE $DESIGN_PHASE
   shift argv
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
svn info $PHASE_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Cannot find Project Design Phase : $DESIGN_PHASE"
   exit 1
endif

echo "INFO: Checkout Project Design Phase : $DESIGN_PHASE"

mkdir -p $PROJT_ROOT/$DESIGN_PHASE

if ($?depth_mode) then
   if {(test -e $PROJT_ROOT/$DESIGN_PHASE/.dvc)} then
      svn update --quiet --force $PROJT_ROOT/$DESIGN_PHASE --set-depth $depth_mode
   else
      svn checkout --force $PHASE_URL $PROJT_ROOT/$DESIGN_PHASE --depth $depth_mode
   endif
endif

if {(test -e $PROJT_ROOT/$DESIGN_PHASE/.dvc)} then
   svn update --quiet --force $PROJT_ROOT/$DESIGN_PHASE/.dvc --set-depth infinity
   svn update --quiet --force $PROJT_ROOT/$DESIGN_PHASE/.dqi --set-depth infinity
else
   svn checkout --force $PHASE_URL/.dvc $PROJT_ROOT/$DESIGN_PHASE/.dvc --depth infinity
   svn checkout --force $PHASE_URL/.dqi $PROJT_ROOT/$DESIGN_PHASE/.dqi --depth infinity
endif

rm -f $PROJT_ROOT/:
ln -s $DESIGN_PHASE $PROJT_ROOT/:

rm -f $CURR_PHASE
if {(test -e $CURR_PHASE)} then
   echo "ERROR: $CURR_PHASE is a folder, rename it!"
else
   ln -s $PROJT_ROOT/$DESIGN_PHASE $CURR_PHASE
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
