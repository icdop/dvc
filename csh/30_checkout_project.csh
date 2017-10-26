#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT> [<PROJT_PATH>]"
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
    setenv PROJT_PATH $1
  else
    setenv PROJT_PATH "_"
  endif
  shift argv
else 
  setenv PROJT_PATH $DESIGN_PROJT
endif

$CSH_DIR/00_set_env.csh PROJT_PATH   $PROJT_PATH

set project=`$CSH_DIR/10_get_env.csh --root $PROJT_PATH/.dvc DESIGN_PROJT`
if {(test -e $PROJT_PATH/.dvc/env/DESIGN_PROJT)} then
   set project=`cat $PROJT_PATH/.dvc/env/DESIGN_PROJT`
   if (($project != "") && ($project != $DESIGN_PROJT)) then
      if ($?force_mode) then
         echo "WARNING: removing previous project checkout data - $project"
         rm -fr $PROJT_PATH
      else
         echo "ERROR: there is existing project checkout data - $project"
         echo "       use --force option to replace it."
         exit 1
      endif
   endif 
endif

mkdir -p $PROJT_PATH

if ($?depth_mode == 0) then
   set depth_mode=files
endif

if {(test -e $PROJT_PATH/.svn)} then
   svn update --quiet --force $PROJT_PATH --set-depth $depth_mode
else
   svn checkout --force $PROJT_URL $PROJT_PATH --depth $depth_mode
endif

if {(test -e $PROJT_PATH/.dvc)} then
   svn update --quiet --force $PROJT_PATH/.dvc --set-depth infinity
else
   svn checkout --quiet --force $PROJT_URL/.dvc $PROJT_PATH/.dvc --depth infinity
endif

if {(test -e $PROJT_PATH/.dqi)} then
   svn update --quiet --force $PROJT_PATH/.dqi --set-depth infinity
else
   svn checkout --quiet --force $PROJT_URL/.dqi $PROJT_PATH/.dqi --depth infinity
endif

if {(test -e $PROJT_PATH/.htm)} then
   svn update --quiet --force $PROJT_PATH/.htm --set-depth infinity
else
   svn checkout --quiet --force $PROJT_URL/.htm $PROJT_PATH/.htm --depth infinity
endif


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
