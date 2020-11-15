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
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/19_get_system.csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/03_set_project.csh

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT

svn info $PROJT_URL >& /dev/null
if (($status == 0) && ($?force_mode == 0)) then
   echo "INFO: Exist Project Design Respository : $DESIGN_PROJT"
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
   svn mkdir --quiet $PROJT_URL/.dqi -m "Design Quality Indicator" --parents
   svn mkdir --quiet $PROJT_URL/.htm -m "HTML Report" --parents
   svn mkdir --quiet $PROJT_URL/.dvc/env -m "DVC environment variable"

#   svn import --quiet --force  $ETC_DIR/jquery   $PROJT_URL/.htm/jquery -m 'jQuery Plugin' 
#   svn import --quiet --force  $ETC_DIR/bootstrap   $PROJT_URL/.htm/bootstrap -m 'Bootstrap Plugin' 
   svn import --quiet --force  $ETC_DIR/rule/DEFINE_PLUGIN   $PROJT_URL/.dvc/DEFINE_PLUGIN -m 'Design Plugin' 
   svn import --quiet --force  $DVC_HOME/REVISION   $PROJT_URL/.dvc/env/DVC_VERSION -m "$DVC_VERSION"

   set tmpfile=`mktemp`
   echo -n $DESIGN_PROJT > $tmpfile
   svn import --quiet --force $tmpfile $PROJT_URL/.dvc/env/DESIGN_PROJT -m 'Project Name'
   rm -f $tmpfile

   set readme=`mktemp`
   echo -n "" > $readme
   echo "# Design Project Root Directory" >> $readme
   echo "====================================" >> $readme
   echo "* Project : $DESIGN_PROJT" >> $readme
   echo "* Author  : $USER" >> $readme
   echo "* Created : `date +%Y%m%d_%H%M%S`" >> $readme
   echo "====================================" >> $readme
   svn import --quiet --force $readme $PROJT_URL/.dvc/README -m 'Initial Design Version Directory'
   rm -fr $readme

endif


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
