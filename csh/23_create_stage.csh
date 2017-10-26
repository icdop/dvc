#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_STAGE>"
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
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh

if ($1 != "") then
   if (($1 != "_") && ($1 != ".")) then
   setenv DESIGN_STAGE $1
   $CSH_DIR/00_set_env.csh DESIGN_STAGE $DESIGN_STAGE
   endif
   shift argv
endif

setenv STAGE_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE
svn info $STAGE_URL >& /dev/null
if (($status == 0) && ($?force_mode == 0)) then
   echo "INFO: Exist Project Design Stage : $DESIGN_STAGE"
   if ($?info_mode) then
      svn info $STAGE_URL
   endif
else

#=========================================================
echo "INFO: Create Project Design Stage : $DESIGN_STAGE"
svn mkdir --quiet $STAGE_URL -m "Create Design Stage $DESIGN_STAGE ..." --parents
svn mkdir --quiet $STAGE_URL/.dvc -m "Design Platform Config Directory" --parents 
svn mkdir --quiet $STAGE_URL/.dqi -m "Design Quality Indicator" --parents 
svn mkdir --quiet $STAGE_URL/.htm -m "HTML Report" --parents 
svn mkdir --quiet $STAGE_URL/.dvc/env -m "DVC environment variable"

svn import --quiet --force  $ETC_DIR/DOP_VERSION   $STAGE_URL/.dvc/env/DOP_VERSION -m "$DOP_VERSION"
#svn import --quiet --force $ETC_DIR/rule/DEFINE_VERSN  $STAGE_URL/.dvc/SUB_FOLDERS -m 'Version Naming Rule'
#svn import --quiet --force $ETC_DIR/rule/DESIGN_FILES  $STAGE_URL/.dvc/DESIGN_FILES -m 'Design Object Table'

set tmpfile=`mktemp`
echo -n "$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE" > $tmpfile
svn import --quiet --force $tmpfile $STAGE_URL/.dvc/env/DESIGN_PATH -m 'Stage Name'
rm -f $tmpfile

set readme=`mktemp`
echo -n "" > $readme
echo "====================================" >> $readme
echo "* Phase   : $DESIGN_PHASE" >> $readme
echo "* Block   : $DESIGN_BLOCK" >> $readme
echo "* Stage   : $DESIGN_STAGE" >> $readme
echo "* Author  : $USER" >> $readme
echo "* Created : `date +%Y%m%d_%H%M%S`" >> $readme
echo "====================================" >> $readme

svn import --quiet --force $readme $STAGE_URL/.dvc/README -m 'Initial Design Stage Directory'
rm -fr $readme
#=========================================================

endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
