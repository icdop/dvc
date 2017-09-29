#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh

if ($1 != "") then
   if (($1 != "_") && ($1 != ".")) then
   setenv DESIGN_VERSN $1
   $CSH_DIR/00_set_env.csh DESIGN_VERSN $DESIGN_VERSN
   endif 
   shift argv
endif

setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
setenv VERSN_URL $STAGE_URL/$DESIGN_VERSN

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
svn mkdir --quiet $VERSN_URL/.dqi -m "Design Quality Indicator" --parents


set tmpfile=`mktemp`
echo -n "" > $tmpfile
echo "====================================" >> $tmpfile
echo "* Phase   : $DESIGN_PHASE" >> $tmpfile
echo "* Block   : $DESIGN_BLOCK" >> $tmpfile
echo "* Stage   : $DESIGN_STAGE" >> $tmpfile
echo "* Version : $DESIGN_VERSN" >> $tmpfile
echo "* Author  : $USER" >> $tmpfile
echo "* Created : `date +%Y%m%d_%H%M%S`" >> $tmpfile
echo "====================================" >> $tmpfile

svn import --quiet $tmpfile $VERSN_URL/.dvc/README -m 'Initial Design Version Directory'

echo -n "/$DVC_PATH" > $tmpfile
svn import --quiet $tmpfile $VERSN_URL/.dvc/VERSION -m 'Design Version Path'

echo -n "/$DVC_PATH/." > $tmpfile
svn import --quiet $tmpfile $VERSN_URL/.dvc/CONTAINER -m 'Design Container Path'

rm -fr $tmpfile
#=========================================================

endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
