#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_STAGE>"
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
   setenv DESIGN_STAGE $1
   echo "INFO: DESIGN_STAGE = $DESIGN_STAGE"
   mkdir -p .dvc/env
   echo $DESIGN_STAGE > .dvc/env/DESIGN_STAGE
endif

setenv BLOCK_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK
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
svn import --quiet $DVC_ETC/csv/dir_version.csv $STAGE_URL/.dvc/NAME_RULE.csv -m 'Version Naming Rule'
svn import --quiet $DVC_ETC/csv/dvc_format.csv $STAGE_URL/.dvc/FILE_FORMAT.csv -m 'Directory Format'


