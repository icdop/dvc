#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PHASE>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
setenv DVC_ETC $DOP_HOME/dvc/etc
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/14_get_version.csh

if ($1 != "") then
   setenv DESIGN_PHASE $1
   echo "SETP: DESIGN_PHASE = $DESIGN_PHASE"
   mkdir -p .dvc/env
   echo $DESIGN_PHASE > .dvc/env/DESIGN_PHASE
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
svn info $PHASE_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Reuse Project Design Phase : $DESIGN_PHASE"
   svn info $PHASE_URL
   exit 0
endif

echo "INFO: Create Project Design Phase : $DESIGN_PHASE"
svn mkdir --quiet $PHASE_URL -m "Create Design Phase $DESIGN_PHASE." --parents
svn mkdir --quiet $PHASE_URL/.dvc -m "Design Platform Config Directory" --parents
svn import --quiet $DVC_ETC/rule/RULE_BLOCK   $PHASE_URL/.dvc/NAME_RULE -m 'Block Naming Rule'
svn import --quiet $DVC_ETC/rule/FILE_FORMAT  $PHASE_URL/.dvc/FILE_FORMAT  -m 'Directory Format'

setenv README "/tmp/README.md"
echo -n "" > $README
echo "# Design Version Control Directory" >> $README
echo "=======================================" >> $README
echo "* Project : $DESIGN_PROJT" >> $README
echo "* Phase   : $DESIGN_PHASE" >> $README
echo "* Path    : .project/$DESIGN_PHASE/" >> $README
echo "* Author  : $USER" >> $README
echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $README
echo "=======================================" >> $README

svn import --quiet $README $PHASE_URL/.dvc/README.md -m 'Initial Design Version Directory'
rm -fr $README

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
