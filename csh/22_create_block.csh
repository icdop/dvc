#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_BLOCK> <DESIGN_PHASE>"
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
   setenv DESIGN_BLOCK $1
   echo "PARA: DESIGN_BLOCK = $DESIGN_BLOCK"
   mkdir -p .dvc/env
   echo $DESIGN_BLOCK > .dvc/env/DESIGN_BLOCK
endif

if ($2 != "") then
    setenv DESIGN_PHASE $1
    echo $DESIGN_PHASE > .dvc/env/DESIGN_PHASE
    echo "INFO: DESIGN_PHASE = $DESIGN_PHASE"
endif


setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
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

setenv README "/tmp/README.md"
echo -n "" > $README
echo "# Design Version Control Directory" >> $README
echo "=======================================" >> $README
echo "* Project : $DESIGN_PROJT" >> $README
echo "* Phase   : $DESIGN_PHASE" >> $README
echo "* Block   : $DESIGN_BLOCK" >> $README
echo "* Path    : .project/$DESIGN_PROJT/$DESIGN_PHASE/$DESIGN_BLOCK/" >> $README
echo "* Author  : $USER" >> $README
echo "* Date    : `date +%Y%m%d_%H%M%S`" >> $README
echo "=======================================" >> $README

svn import --quiet $README $BLOCK_URL/.dvc/README.md -m 'Initial Design Version Directory'
rm -fr $README

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo ""
exit 0
