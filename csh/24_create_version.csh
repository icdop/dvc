#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
setenv DVC_ETC $DOP_HOME/dvc/etc
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/04_set_version.csh

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
setenv VERSN_URL $STAGE_URL/$DESIGN_VERSN
svn info $VERSN_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Reuse Project Design Version : $DESIGN_VERSN"
   svn info $VERSN_URL
   exit 0
endif

echo "INFO: Create Project Design Version : $DESIGN_STAGE/$DESIGN_VERSN"
svn mkdir --quiet $VERSN_URL -m "Create Design Version /$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_VERSN ..." --parents
svn mkdir --quiet $VERSN_URL/.dvc -m "Design Platform Config Directory"
svn copy  --quiet $BLOCK_URL/.dvc/FILE_FORMAT  $VERSN_URL/.dvc/FILE_FORMAT -m 'Design Object Format' 
svn copy  --quiet $BLOCK_URL/.dvc/FILE_OBJECT  $VERSN_URL/.dvc/FILE_OBJECT -m 'Design Object Table' 
svn mkdir --quiet $VERSN_URL/.dqi -m "Create Design Container" --parents

setenv README "/tmp/README.`date +%Y%m%d_%H%M%S`"
echo -n "" > $README
echo "# Design Version Control Directory" >> $README
echo "=======================================" >> $README
echo "* Project : $DESIGN_PROJT" >> $README
echo "* Phase   : $DESIGN_PHASE" >> $README
echo "* Block   : $DESIGN_BLOCK" >> $README
echo "* Stage   : $DESIGN_STAGE" >> $README
echo "* Version : $DESIGN_VERSN" >> $README
echo "* Path    : .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN/" >> $README
echo "* Author  : $USER" >> $README
echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $README
echo "=======================================" >> $README
svn import --quiet $README $VERSN_URL/.dvc/README.md -m 'Initial Design Version Directory'
rm -fr $README

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
