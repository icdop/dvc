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
   setenv DESIGN_PTR $PTR_VERSN
endif

setenv DESIGN_URL  $SVN_URL/$DESIGN_PROJT/$DVC_PATH
setenv DESIGN_PATH $PROJT_PATH/$DVC_PATH
mkdir -p $DESIGN_PATH

if ($?force_mode) then
   rm -f $DESIGN_PATH
endif

if ($?depth_mode) then
   if {(test -e $DESIGN_PATH/.svn)} then
      svn update --quiet --force $DESIGN_PATH --set-depth $depth_mode
   else
      svn checkout --quiet --force $DESIGN_URL $DESIGN_PATH --depth $depth_mode
   endif
endif

if {(test -e $DESIGN_PATH/.svn)} then
   svn update --quiet --force $DESIGN_PATH --set-depth files
else
   svn checkout --quiet --force $DESIGN_URL $DESIGN_PATH --depth files
endif

if {(test -e $DESIGN_PATH/.dvc)} then
   svn update --quiet --force $DESIGN_PATH/.dvc --set-depth infinity
else
   svn checkout --quiet --force $DESIGN_URL/.dvc $DESIGN_PATH/.dvc --depth infinity
endif

if {(test -e $DESIGN_PATH/.dqi)} then
   svn update --quiet --force $DESIGN_PATH/.dqi --set-depth infinity
else
   svn checkout --quiet --force $DESIGN_URL/.dqi $DESIGN_PATH/.dqi --depth infinity
endif

if {(test -e $DESIGN_PATH/.htm)} then
   svn update --quiet --force $DESIGN_PATH/.htm --set-depth infinity
else
   svn checkout --quiet --force $DESIGN_URL/.htm $DESIGN_PATH/.htm --depth infinity
endif

set dvc_name = $DESIGN_PATH:t
set dvc_root = $DESIGN_PATH:h
if ($?PTR_CURR) then
   rm -f $dvc_root/$PTR_CURR
   ln -s $dvc_name $dvc_root/$PTR_CURR
   svn propset svn:ignore $PTR_CURR $dvc_root
#   svn propset svn:global-ignores $PTR_CURR $dvc_root
endif

if ($?DESIGN_PTR) then
   rm -f $DESIGN_PTR
   ln -s $DESIGN_PATH $DESIGN_PTR
endif

exit 0
