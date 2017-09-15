#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
   exit -1
endif
#echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/03_set_project.csh

svn info $PROJT_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Reuse Project Design Respository : $DESIGN_PROJT"
   if ($?info_mode) then
      svn info $PROJT_URL
   endif
else

   echo "INFO: Create Project Design Respository : $DESIGN_PROJT"
   if {(test -d $SVN_ROOT)} then
   else
     mkdir -p $SVN_ROOT
   endif 
   if {(test -d $SVN_ROOT/DESIGN_PROJT)} then
   else
     svnadmin create $SVN_ROOT/$DESIGN_PROJT
     cp -fr $ETC_DIR/conf/* $SVN_ROOT/$DESIGN_PROJT/conf
   endif

#   svn auth  $PROJT_URL --username pm --password pm

   svn mkdir --quiet $PROJT_URL/.dvc -m "Design Platform Config Directory" --parents
   svn import --quiet  $ETC_DIR/rule/DEFINE_PHASE   $PROJT_URL/.dvc/SUB_FOLDER_RULE -m 'Phase Naming Rule' 
   svn import --quiet  $ETC_DIR/rule/FILE_PLUGINS   $PROJT_URL/.dvc/FILE_PLUGINS -m 'Design Plugin' 

   set readme="/tmp/README_PROJT.txt"
   echo -n "" > $readme
   echo "# Design Version Control Directory" >> $readme
   echo "=======================================" >> $readme
   echo "* Project : $DESIGN_PROJT" >> $readme
   echo "* Path    : $DESIGN_PROJT/" >> $readme
   echo "* Author  : $USER" >> $readme
   echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $readme
   echo "=======================================" >> $readme
   svn import --quiet $readme $PROJT_URL/.dvc/README -m 'Initial Design Version Directory'
   rm -fr $readme
   
endif

#echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
