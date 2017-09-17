#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/03_set_project.csh

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT

svn info $PROJT_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Can not find Project Design Respository : $DESIGN_PROJT"
   exit 1
endif

echo "INFO: Checkout Project Design Respository : $DESIGN_PROJT"
#svn auth  $PROJT_URL --username db --password db

if {(test -e $CURR_PROJT/.dvc/PROJECT)} then
   set orig_project=`cat $CURR_PROJT/.dvc/PROJECT`
   if (($orig_project != "") && ($orig_project != $DESIGN_PROJT)) then
      if ($?force_mode == 1) then
         echo "WARNING: removing previous project checkout data - $orig_project"
         rm -fr $CURR_PROJT
      else
         echo "ERROR: there is existing project checkout data - $orig_project"
         echo "       use --force option to replace it."
         setenv DESIGN_PROJT $orig_project
         exit -1
      endif
   endif 
endif

mkdir -p $CURR_PROJT

if {(test -e $CURR_PROJT/.dvc)} then
#   svn update --quiet --force $CURR_PROJT --set-depth $depth_mode
   svn update --quiet --force $CURR_PROJT/.dvc
else
#   svn checkout --force $PROJT_URL $CURR_PROJT --depth $depth_mode
   svn checkout --force $PROJT_URL/.dvc $CURR_PROJT/.dvc --depth infinity
endif

$CSH_DIR/00_set_env.csh DESIGN_PROJT $DESIGN_PROJT

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
