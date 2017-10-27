#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_BLOCK>"
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
   setenv DESIGN_BLOCK $1
   $CSH_DIR/00_set_env.csh DESIGN_BLOCK $DESIGN_BLOCK
   endif
   shift argv
endif

setenv BLOCK_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK
svn info $BLOCK_URL >& /dev/null
if (($status == 0) && ($?force_mode == 0)) then
   echo "INFO: Exist Project Design Block : $DESIGN_BLOCK"
   if ($?info_mode) then
      svn info $BLOCK_URL
   endif
else

#=========================================================
echo "INFO: Create Project Design Block : $DESIGN_BLOCK"
svn mkdir --quiet $BLOCK_URL -m "Create Design Block $DESIGN_BLOCK." --parents
svn mkdir --quiet $BLOCK_URL/.dvc -m "Design Platform Config File" --parents
svn mkdir --quiet $BLOCK_URL/.dqi -m "Design Quality Indicator" --parents
svn mkdir --quiet $BLOCK_URL/.htm -m "HTML Report" --parents
svn mkdir --quiet $BLOCK_URL/.dvc/env -m "DVC environment variable"


svn import --quiet --force  $ETC_DIR/DOP_VERSION   $BLOCK_URL/.dvc/env/DOP_VERSION -m "$DOP_VERSION"

set tmpfile=`mktemp`
echo -n "$DESIGN_PHASE/$DESIGN_BLOCK" > $tmpfile
svn import --quiet --force $tmpfile $BLOCK_URL/.dvc/env/DESIGN_PATH -m 'Block Name'
rm -f $tmpfile

set readme=`mktemp`
echo -n "" > $readme
echo "====================================" >> $readme
echo "* Phase   : $DESIGN_PHASE" >> $readme
echo "* Block   : $DESIGN_BLOCK" >> $readme
echo "* Author  : $USER" >> $readme
echo "* Created : `date +%Y%m%d_%H%M%S`" >> $readme
echo "====================================" >> $readme

svn import --quiet --force $readme $BLOCK_URL/.dvc/README -m 'Initial Design Block Directory'
rm -fr $readme
#=========================================================

endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
