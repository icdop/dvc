#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT> [<PROJT_ROOT>]"
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
if ($status != 0) then
   echo "ERROR: Can not find Project Design Respository : $DESIGN_PROJT"
   exit 1
endif

echo "INFO: Checkout Project Design Respository : $DESIGN_PROJT"
#svn auth  $PROJT_URL --username db --password db
if ($1 != "") then
  if (($1 != "..") && ($1 != ".")) then
    setenv PROJT_ROOT $1
  endif
  shift argv
endif


if {(test -e $PROJT_ROOT/.dqi/DESIGN_PROJT)} then
   set orig_project=`cat $PROJT_ROOT/.dqi/DESIGN_PROJT`
   if (($orig_project != "") && ($orig_project != $DESIGN_PROJT)) then
      if ($?force_mode) then
         echo "WARNING: removing previous project checkout data - $orig_project"
         rm -fr $PROJT_ROOT
      else
         echo "ERROR: there is existing project checkout data - $orig_project"
         echo "       use --force option to replace it."
         setenv DESIGN_PROJT $orig_project
         exit 1
      endif
   endif 
endif

mkdir -p $PROJT_ROOT

if ($?depth_mode) then
   if {(test -e $PROJT_ROOT/.svn)} then
      svn update --quiet --force $PROJT_ROOT --set-depth $depth_mode
   else
      svn checkout --quiet --force $PROJT_URL $PROJT_ROOT --depth $depth_mode
   endif
endif

if {(test -e $PROJT_ROOT/.dvc)} then
   svn update --quiet --force $PROJT_ROOT/.dvc --set-depth infinity
else
   svn checkout --quiet --force $PROJT_URL/.dvc $PROJT_ROOT/.dvc --depth infinity
endif

if {(test -e $PROJT_ROOT/.dqi)} then
   svn update --quiet --force $PROJT_ROOT/.dqi --set-depth infinity
else
   svn checkout --quiet --force $PROJT_URL/.dqi $PROJT_ROOT/.dqi --depth infinity
endif

if {(test -e $PROJT_ROOT/.htm)} then
   svn update --quiet --force $PROJT_ROOT/.htm --set-depth infinity
else
   svn checkout --quiet --force $PROJT_URL/.htm $PROJT_ROOT/.htm --depth infinity
endif

$CSH_DIR/00_set_env.csh DESIGN_PROJT $DESIGN_PROJT

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
