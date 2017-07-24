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
source $DVC_CSH/12_get_version.csh

if ($1 != "") then
   setenv DESIGN_VERSN $1
   echo "INFO: DESIGN_VERSN = $DESIGN_VERSN"
   mkdir -p .dvc/env
   echo $DESIGN_VERSN > .dvc/env/DESIGN_VERSN
endif

if ($2 != "") then
    setenv DESIGN_STAGE $2
    echo $DESIGN_STAGE > .dvc/env/DESIGN_STAGE
    echo "INFO: DESIGN_STAGE = $DESIGN_STAGE"
else
    setenv DESIGN_STAGE  `cat .dvc/env/DESIGN_STAGE`
endif

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
svn mkdir --quiet $VERSN_URL/.dqi -m "Design Quality Indicator"
svn mkdir --quiet $VERSN_URL/.dvc -m "Design Platform Config Directory"
svn copy  --quiet $BLOCK_URL/.dvc/FILE_FORMAT.csv  $VERSN_URL/.dvc/FILE_FORMAT.csv -m 'Design Object Format' 
svn copy  --quiet $BLOCK_URL/.dvc/VARIABLE.csv  $VERSN_URL/.dvc/VARIABLE.csv -m 'Design Variable Table' 

setenv README "/tmp/README.md"
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
rm -f $README

rm -f /tmp/.current_version
ln -s $DESIGN_VERSN /tmp/.current_version
svn import --quiet --force /tmp/.current_version $STAGE_URL/.current_version -m 'Current Design Version $DESIGN_VERSN'
rm -f /tmp/.current_version


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
