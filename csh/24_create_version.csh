#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN>"
   exit -1
endif
#echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

# do not set current link in creation mode
set no_curr_link=1

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/04_set_version.csh

setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
setenv VERSN_URL $STAGE_URL/$DESIGN_VERSN

svn info $PHASE_URL >& /dev/null
if ($status == 1) then
   $CSH_DIR/21_create_phase.csh $DESIGN_PHASE
endif

svn info $BLOCK_URL >& /dev/null
if ($status == 1) then
   $CSH_DIR/22_create_block.csh $DESIGN_BLOCK
endif

svn info $STAGE_URL >& /dev/null
if ($status == 1) then
   $CSH_DIR/23_create_stage.csh $DESIGN_STAGE
endif

svn info $VERSN_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Exist Project Design Version : $DESIGN_VERSN"
   if ($?info_mode) then
      svn info $VERSN_URL
   endif
else

#=========================================================
echo "INFO: Create Project Design Version : $DESIGN_VERSN"
svn mkdir --quiet $VERSN_URL -m "Create Design Version $DESIGN_VERSN ..." --parents
svn mkdir --quiet $VERSN_URL/.dvc -m "DVC Config Directory" --parents
svn copy  --quiet $STAGE_URL/.dvc/DESIGN_FILES  $VERSN_URL/.dvc/DESIGN_FILES -m 'Design Object Table' 
#svn mkdir --quiet $VERSN_URL/.dqi -m "Create Design Quality Indicator Folder" --parents

#set tmpfile="/tmp/tmpfile.`date +%Y%m%d_%H%M%S`"
set tmpfile=`mktemp`
echo -n "" > $tmpfile
echo "# Design Version Control Directory" >> $tmpfile
echo "=======================================" >> $tmpfile
echo "* Project : $DESIGN_PROJT" >> $tmpfile
echo "* Phase   : $DESIGN_PHASE" >> $tmpfile
echo "* Block   : $DESIGN_BLOCK" >> $tmpfile
echo "* Stage   : $DESIGN_STAGE" >> $tmpfile
echo "* Version : $DESIGN_VERSN" >> $tmpfile
echo "* Path    : $DESIGN_PROJT/$DVC_PATH/" >> $tmpfile
echo "* Author  : $USER" >> $tmpfile
echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $tmpfile
echo "=======================================" >> $tmpfile

svn import --quiet $tmpfile $VERSN_URL/.dvc/README -m 'Initial Design Version Directory'

echo -n "/$DVC_PATH" > $tmpfile
svn import --quiet $tmpfile $VERSN_URL/.dvc/VERSION -m 'Design Version Path'

echo -n "/$DVC_PATH/." > $tmpfile
svn import --quiet $tmpfile $VERSN_URL/.dvc/CONTAINER -m 'Design Container Path'

rm -fr $tmpfile
#=========================================================

endif

#echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
