#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_STAGE>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv CSH_DIR $DOP_HOME/dvc/csh
setenv ETC_DIR $DOP_HOME/dvc/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if ($1 != "") then
   setenv DESIGN_STAGE $1
   echo "SETP: DESIGN_STAGE = $DESIGN_STAGE"
   mkdir -p .dvc/env
   echo $DESIGN_STAGE > .dvc/env/DESIGN_STAGE
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
svn info $STAGE_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Reuse Project Design Stage : $DESIGN_STAGE"
   svn info $STAGE_URL
   exit 0
endif

echo "INFO: Create Project Design Stage : $DESIGN_STAGE"
svn mkdir --quiet $STAGE_URL -m "Create Design Stage /$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE ..." --parents
svn mkdir --quiet $STAGE_URL/.dvc -m "Design Platform Config" 
svn import --quiet $ETC_DIR/rule/RULE_VERSN  $STAGE_URL/.dvc/NAME_RULE -m 'Version Naming Rule'
svn import --quiet $ETC_DIR/rule/FILE_FORMAT $STAGE_URL/.dvc/FILE_FORMAT -m 'Directory Format'

setenv README "/tmp/README.md"
echo -n "" > $README
echo "# Design Version Control Directory" >> $README
echo "=======================================" >> $README
echo "* Project : $DESIGN_PROJT" >> $README
echo "* Phase   : $DESIGN_PHASE" >> $README
echo "* Block   : $DESIGN_BLOCK" >> $README
echo "* Stage   : $DESIGN_STAGE" >> $README
echo "* Path    : .project/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/" >> $README
echo "* Author  : $USER" >> $README
echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $README
echo "=======================================" >> $README

svn import --quiet $README $STAGE_URL/.dvc/README.md -m 'Initial Design Version Directory'
rm -fr $README

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
