#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_STAGE>"
   exit -1
endif
#echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if ($1 != "") then
   setenv DESIGN_STAGE $1
   $CSH_DIR/00_set_env.csh --quiet DESIGN_STAGE $DESIGN_STAGE
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
svn info $STAGE_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Exist Project Design Stage : $DESIGN_STAGE"
   if ($?info_mode) then
      svn info $STAGE_URL
   endif
else

#=========================================================
echo "INFO: Create Project Design Stage : $DESIGN_STAGE"
svn mkdir --quiet $STAGE_URL -m "Create Design Stage $DESIGN_STAGE ..." --parents
svn mkdir --quiet $STAGE_URL/.dvc -m "Design Platform Config Directory" --parents 
svn import --quiet $ETC_DIR/rule/DEFINE_VERSN  $STAGE_URL/.dvc/SUB_FOLDER_RULE -m 'Version Naming Rule'
svn import --quiet $ETC_DIR/rule/DESIGN_FILES $STAGE_URL/.dvc/DESIGN_FILES -m 'Design Object Table'

set readme="/tmp/readme_STAGE.md"
echo -n "" > $readme
echo "# Design Version Control Directory" >> $readme
echo "=======================================" >> $readme
echo "* Project : $DESIGN_PROJT" >> $readme
echo "* Phase   : $DESIGN_PHASE" >> $readme
echo "* Block   : $DESIGN_BLOCK" >> $readme
echo "* Stage   : $DESIGN_STAGE" >> $readme
echo "* Path    : $DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/" >> $readme
echo "* Author  : $USER" >> $readme
echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $readme
echo "=======================================" >> $readme

svn import --quiet $readme $STAGE_URL/.dvc/README -m 'Initial Design Stage Directory'
rm -fr $readme
#=========================================================

endif

#echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
