#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_PHASE>"
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
   setenv DESIGN_PHASE $1
   echo "INFO: DESIGN_PHASE = $DESIGN_PHASE"
   mkdir -p .dvc/env
   echo $DESIGN_PHASE > .dvc/env/DESIGN_PHASE
endif

setenv PHASE_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE
svn info $PHASE_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Reuse Project Design Phase : $DESIGN_PHASE"
   svn info $PHASE_URL
   exit 0
endif

echo "INFO: Create Project Design Phase : $DESIGN_PHASE"
svn mkdir --quiet $PHASE_URL -m "Create Design Phase $DESIGN_PHASE." --parents
svn mkdir --quiet $PHASE_URL/.dvc -m "Design Platform Config Directory" --parents
svn import --quiet $DVC_ETC/csv/dvc_format.csv   $PHASE_URL/.dvc/FILE_FORMAT.csv -m 'Directory Format'
svn import --quiet $DVC_ETC/csv/dir_block.csv   $PHASE_URL/.dvc/NAME_RULE.csv -m 'Block Naming Rule'

