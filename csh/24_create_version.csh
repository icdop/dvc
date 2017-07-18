#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif

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

setenv BLOCK_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK
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
svn copy  --quiet $BLOCK_URL/.dvc/FILE_FORMAT.csv  $VERSN_URL/.dvc/FILE_FORMAT.csv -m 'Design Object Format' 
svn copy  --quiet $BLOCK_URL/.dvc/VARIABLE.csv  $VERSN_URL/.dvc/VARIABLE.csv -m 'Design Variable Table' 

svn mkdir --quiet $VERSN_URL/.dqi -m "Design Quality Indicator Directory"
