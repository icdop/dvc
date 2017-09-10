#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PHASE>"
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
   setenv DESIGN_PHASE $1
   $CSH_DIR/00_set_env.csh DESIGN_PHASE $DESIGN_PHASE
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
svn info $PHASE_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Project Design Phase : $DESIGN_PHASE"
   if ($?info_mode) then
      svn info $PHASE_URL
   endif
else

#=========================================================
echo "INFO: Create Project Design Phase : $DESIGN_PHASE"
svn mkdir --quiet $PHASE_URL -m "Create Design Phase $DESIGN_PHASE ..." --parents
svn mkdir --quiet $PHASE_URL/.dvc -m "Design Platform Config Directory" --parents

setenv README "/tmp/README_PHASE.md"
echo -n "" > $README
echo "# Design Version Control Directory" >> $README
echo "=======================================" >> $README
echo "* Project : $DESIGN_PROJT" >> $README
echo "* Phase   : $DESIGN_PHASE" >> $README
echo "* Path    : .project/$DESIGN_PHASE/" >> $README
echo "* Author  : $USER" >> $README
echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $README
echo "=======================================" >> $README

svn import --quiet $README $PHASE_URL/.dvc/README.txt -m 'Initial Design Phase Directory'
rm -fr $README
#=========================================================

endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
