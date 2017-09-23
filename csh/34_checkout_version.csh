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
mkdir -p $PROJT_ROOT/$DVC_PATH

if ($?depth_mode) then
   if {(test -e $PROJT_ROOT/$DVC_PATH/.dvc)} then
      svn update --quiet --force $PROJT_ROOT/$DVC_PATH --set-depth $depth_mode
   else
      svn checkout --force $VERSN_URL $PROJT_ROOT/$DVC_PATH --depth $depth_mode
   endif
endif
if {(test -e $PROJT_ROOT/$DVC_PATH/.dvc)} then
   svn update --quiet --force $PROJT_ROOT/$DVC_PATH/.dvc --set-depth infinity
   svn update --quiet --force $PROJT_ROOT/$DVC_PATH/.dqi --set-depth infinity
else
   svn checkout --force $VERSN_URL/ $PROJT_ROOT/$DVC_PATH/ --depth empty
   svn checkout --force $VERSN_URL/.dvc $PROJT_ROOT/$DVC_PATH/.dvc --depth infinity
   svn checkout --force $VERSN_URL/.dqi $PROJT_ROOT/$DVC_PATH/.dqi --depth infinity
endif

rm -f $PROJT_ROOT/:
rm -f $PROJT_ROOT/$DESIGN_PHASE/:
rm -f $PROJT_ROOT/$DESIGN_PHASE/$DESIGN_BLOCK/:
rm -f $PROJT_ROOT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/:
ln -s $DESIGN_PHASE $PROJT_ROOT/:
ln -s $DESIGN_BLOCK $PROJT_ROOT/$DESIGN_PHASE/:
ln -s $DESIGN_STAGE $PROJT_ROOT/$DESIGN_PHASE/$DESIGN_BLOCK/:
ln -s $DESIGN_VERSN $PROJT_ROOT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/:

rm -f $CURR_VERSN
if {(test -e $CURR_VERSN)} then
   echo "ERROR: $CURR_VERSN is a folder, rename it!"
else
   ln -s $PROJT_ROOT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN $CURR_VERSN
endif

$CSH_DIR/05_set_container.csh .

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
