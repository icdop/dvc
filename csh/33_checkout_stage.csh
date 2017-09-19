#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_STAGE>"
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
   setenv DESIGN_STAGE $1
   $CSH_DIR/00_set_env.csh DESIGN_STAGE $DESIGN_STAGE
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
svn info $STAGE_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Cannot find Project Design Stage : $DESIGN_STAGE"
   exit 1
endif

echo "INFO: Checkout Project Design Stage : $DESIGN_STAGE"
mkdir -p $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE

if ($?depth_mode) then
   if {(test -e $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc)} then
      svn update --quiet --force $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE --set-depth $depth_mode
   else
      svn checkout --force $STAGE_URL $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE --depth $depth_mode
   endif
endif

if {(test -e $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc)} then
   svn update --quiet --force $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc --set-depth infinity
   svn update --quiet --force $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dqi --set-depth infinity
else
   svn checkout --force $STAGE_URL/.dvc $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dvc --depth infinity
   svn checkout --force $STAGE_URL/.dqi $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/.dqi --depth infinity
endif


rm -f $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/:
ln -s $DESIGN_STAGE $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/:

rm -f $CURR_STAGE
if {(test -e $CURR_STAGE)} then
   echo "ERROR: $CURR_STAGE is a folder, rename it!"
else
   ln -s $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE $CURR_STAGE
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
