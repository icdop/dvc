#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_BLOCK>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if ($1 != "") then
   setenv DESIGN_BLOCK $1
   $CSH_DIR/00_set_env.csh DESIGN_BLOCK $DESIGN_BLOCK
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
svn info $BLOCK_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Reuse Project Design Block : $DESIGN_BLOCK"
   if ($?info_mode) then
      svn info $BLOCK_URL
   endif
else

#=========================================================
echo "INFO: Create Project Design Block : $DESIGN_BLOCK"
svn mkdir --quiet $BLOCK_URL -m "Create Design Block $DESIGN_BLOCK." --parents
svn mkdir --quiet $BLOCK_URL/.dvc -m "Design Platform Config File" --parents
svn import --quiet $ETC_DIR/rule/DEFINE_STAGE    $BLOCK_URL/.dvc/SUB_FOLDER_RULE -m 'Stage Naming Rule'

setenv README "/tmp/README_BLOCK.md"
echo -n "" > $README
echo "# Design Version Control Directory" >> $README
echo "=======================================" >> $README
echo "* Project : $DESIGN_PROJT" >> $README
echo "* Phase   : $DESIGN_PHASE" >> $README
echo "* Block   : $DESIGN_BLOCK" >> $README
echo "* Path    : $DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/" >> $README
echo "* Author  : $USER" >> $README
echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $README
echo "=======================================" >> $README

svn import --quiet $README $BLOCK_URL/.dvc/README.txt -m 'Initial Design Block Directory'
rm -fr $README
#=========================================================

endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
