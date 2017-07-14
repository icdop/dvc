#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif
echo "INFO: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DVC_BIN $0:h
   setenv DVC_ETC $DVC_BIN/../../dvc/etc
else
   setenv DVC_BIN $DOP_HOME/dvc/bin
   setenv DVC_ETC $DOP_HOME/dvc/etc
endif
source $DVC_BIN/dvc_get_svn

if ($1 != "") then
   setenv DESIGN_PROJT $1
   echo "INFO: DESIGN_PROJT = $DESIGN_PROJT"
   mkdir -p .dvc/env
   echo $DESIGN_PROJT > .dvc/env/DESIGN_PROJT
endif

if {(test -e $SVN_ROOT/$DESIGN_PROJT/conf)} then
   echo "INFO: Reuse Project Design Respository : $DESIGN_PROJT"
else
   echo "INFO: Initial Project Design Respository : $DESIGN_PROJT"
   svnadmin create $SVN_ROOT/$DESIGN_PROJT
   cp -fr $DVC_ETC/svn/* $SVN_ROOT/$DESIGN_PROJT/conf

   #svn auth  $SVN_URL/$DESIGN_PROJT --username db --password dvc

   svn mkdir --quiet $SVN_URL/$DESIGN_PROJT/.dvc -m "Design Platform Config Directory" --parents
   svn import --quiet  $DVC_ETC/csv/dir_phase.csv    $SVN_URL/$DESIGN_PROJT/.dvc/NAME_RULE.csv -m 'Phase Naming Rule' 
   svn import --quiet  $DVC_ETC/csv/dvc_format.csv   $SVN_URL/$DESIGN_PROJT/.dvc/FILE_FORMAT.csv -m 'Directory Format' 

endif

echo "INFO: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
