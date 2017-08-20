#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
setenv DVC_ETC $DOP_HOME/dvc/etc
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/03_set_project.csh

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
svn info $PROJT_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Reuse Project Design Respository : $DESIGN_PROJT"
   svn info $PROJT_URL
   exit 0
endif

   echo "INFO: Initial Project Design Respository : $DESIGN_PROJT"
   if {(test -d $SVN_ROOT)} then
   else
     mkdir -p $SVN_ROOT
   endif 
   if {(test -d $SVN_ROOT/DESIGN_PROJT)} then
   else
     svnadmin create $SVN_ROOT/$DESIGN_PROJT
     cp -fr $DVC_ETC/svn/* $SVN_ROOT/$DESIGN_PROJT/conf
   endif

#   svn auth  $PROJT_URL --username pm --password pm

   svn mkdir --quiet $PROJT_URL/.dvc -m "Design Platform Config Directory" --parents
   svn import --quiet  $DVC_ETC/rule/RULE_PHASE    $PROJT_URL/.dvc/NAME_RULE -m 'Phase Naming Rule' 
   svn import --quiet  $DVC_ETC/rule/FILE_FORMAT   $PROJT_URL/.dvc/FILE_FORMAT -m 'Directory Format' 


setenv README "/tmp/README.md"
echo -n "" > $README
echo "# Design Version Control Directory" >> $README
echo "=======================================" >> $README
echo "* Project : $DESIGN_PROJT" >> $README
echo "* Path    : .project/$DESIGN_PROJT/" >> $README
echo "* Author  : $USER" >> $README
echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $README
echo "=======================================" >> $README
svn import --quiet $README $PROJT_URL/.dvc/README.md -m 'Initial Design Version Directory'
rm -fr $README

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
