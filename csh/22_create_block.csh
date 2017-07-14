#!/bin/csh -f
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_BLOCK> <DESIGN_PHASE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DVC_BIN $0:h
   setenv DVC_ETC $DVC_BIN/../../dvc/etc
else
   setenv DVC_BIN $DOP_HOME/dvc/bin
   setenv DVC_ETC $DOP_HOME/dvc/etc
endif
source $DVC_BIN/dvc_get_svn
source $DVC_BIN/dvc_get_version

if ($1 != "") then
   setenv DESIGN_BLOCK $1
   echo "INFO: DESIGN_BLOCK = $DESIGN_BLOCK"
   mkdir -p .dvc/env
   echo $DESIGN_BLOCK > .dvc/env/DESIGN_BLOCK
endif

if ($2 != "") then
    setenv DESIGN_PHASE $1
    echo $DESIGN_PHASE > .dvc/env/DESIGN_PHASE
    echo "INFO: DESIGN_PHASE = $DESIGN_PHASE"
endif


setenv BLOCK_URL $SVN_URL/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK
svn info $BLOCK_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Reuse Project Design Block : $DESIGN_BLOCK"
   svn info $BLOCK_URL
   exit 0
endif

echo "INFO: Create Project Design Block : $DESIGN_PHASE/$DESIGN_BLOCK"
svn mkdir --quiet $BLOCK_URL -m "Create Design $DESIGN_BLOCK." --parents
svn mkdir --quiet $BLOCK_URL/.dvc -m "Design Platform Config File" --parents
svn import --quiet $DVC_ETC/csv/dir_stage.csv    $BLOCK_URL/.dvc/NAME_RULE.csv -m 'Stage Naming Rule'
svn import --quiet $DVC_ETC/csv/dvc_format.csv   $BLOCK_URL/.dvc/FILE_FORMAT.csv -m 'Directory Format'  
svn import --quiet $DVC_ETC/csv/dvc_variable.csv   $BLOCK_URL/.dvc/VARIABLE.csv -m 'Default Variable Table' 
