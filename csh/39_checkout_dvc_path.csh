#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DVC_PATH>"
   exit -1
endif
#echo "======================================================="
#echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh

# If DVC_PATH is defined and no args is specified
# it may be called form other dvc_checkout_* command
# this is used to preserved all option modes of parent commands 

if (($1 != "") && ($1 != ":") && ($1 != ".")) then
   setenv DVC_PATH $1
else if ($?DVC_PATH == 0) then
   source $CSH_DIR/14_get_design.csh
   setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
   setenv CURR_PTR $CURR_VERSN
endif

setenv DESIGN_URL $PROJT_URL/$DVC_PATH
mkdir -p $PROJT_ROOT/$DVC_PATH

if ($?depth_mode) then
   if {(test -e $PROJT_ROOT/$DVC_PATH/.dvc)} then
      svn update --quiet --force $PROJT_ROOT/$DVC_PATH --set-depth $depth_mode
   else
      svn checkout --force $DESIGN_URL $PROJT_ROOT/$DVC_PATH --depth $depth_mode
   endif
endif

if {(test -e $PROJT_ROOT/$DVC_PATH/.dvc)} then
   svn update --quiet --force $PROJT_ROOT/$DVC_PATH/.dvc --set-depth infinity
   svn update --quiet --force $PROJT_ROOT/$DVC_PATH/.dqi --set-depth infinity
else
   svn checkout --force $DESIGN_URL/ $PROJT_ROOT/$DVC_PATH/ --depth empty
   svn checkout --force $DESIGN_URL/.dvc $PROJT_ROOT/$DVC_PATH/.dvc --depth infinity
   svn checkout --force $DESIGN_URL/.dqi $PROJT_ROOT/$DVC_PATH/.dqi --depth infinity
endif

set dvc_name = $DVC_PATH:t
set dvc_root = $DVC_PATH:h
rm -fr $PROJT_ROOT/$dvc_root/:
ln -s $dvc_name $PROJT_ROOT/$dvc_root/:

rm -f $CURR_PTR
if {(test -d $CURR_PTR)} then
   echo "ERROR: $CURR_PTR is a folder, rename it!"
else
   ln -fs $PROJT_ROOT/$DVC_PATH $CURR_PTR
endif

exit 0
