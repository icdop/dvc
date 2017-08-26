#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
setenv DVC_ETC $DOP_HOME/dvc/etc
source $DVC_CSH/12_get_server.csh
source $DVC_CSH/13_get_project.csh
source $DVC_CSH/14_get_version.csh

if (($1 != "") && ($1 != ".")) then
   setenv DESIGN_VERSN $1
   echo "PARA: DESIGN_VERSN = $DESIGN_VERSN"
endif

if (($2 != "") && ($2 != ".")) then
    setenv DESIGN_STAGE $2
    echo "PARA: DESIGN_STAGE = $DESIGN_STAGE"
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
setenv STAGE_URL $BLOCK_URL/$DESIGN_STAGE
setenv VERSN_URL $STAGE_URL/$DESIGN_VERSN
svn info $VERSN_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Version : $DESIGN_VERSN"
   exit 1
endif

#svn info $VERSN_URL
echo "URL: $VERSN_URL"
echo "------------------------------------------------------------"
svn list $VERSN_URL -v

exit 0
