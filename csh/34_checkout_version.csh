#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN>"
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
source $CSH_DIR/04_set_version.csh

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
setenv VERSN_URL $STAGE_URL/$DESIGN_VERSN

svn info $VERSN_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Cannot find Project Design Version : $DESIGN_VERSN"
   exit 1
endif

echo "INFO: Checkout Project Design Version : $DESIGN_VERSN"

setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
mkdir -p $CURR_PROJT/$DVC_PATH

if {(test -e $CURR_PROJT/$DVC_PATH/.dvc)} then
   svn update --quiet --force $CURR_PROJT/$DVC_PATH --set-depth $depth_mode
   svn update --quiet --force $CURR_PROJT/$DVC_PATH/.dvc --set-depth infinity
else
   svn checkout --force $VERSN_URL $CURR_PROJT/$DVC_PATH --depth $depth_mode
   svn checkout --force $VERSN_URL/.dvc $CURR_PROJT/$DVC_PATH/.dvc --depth infinity
endif

rm -f $CURR_PROJT/:
rm -f $CURR_PROJT/$DESIGN_PHASE/:
rm -f $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/:
rm -f $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/:
ln -s $DESIGN_PHASE $CURR_PROJT/:
ln -s $DESIGN_BLOCK $CURR_PROJT/$DESIGN_PHASE/:
ln -s $DESIGN_STAGE $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/:
ln -s $DESIGN_VERSN $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/:

if {(test -h $CURR_VERSN)} then
   rm -f $CURR_VERSN
else if {(test -d $CURR_VERSN)} then
   echo "ERROR: $CURR_VERSN is a folder, rename it!"
   mv $CURR_VERSN version.`date +%Y%m%d_%H%M%S`
endif
ln -fs $CURR_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN $CURR_VERSN

$CSH_DIR/05_set_container.csh .

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
