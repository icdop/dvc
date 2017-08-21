#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_BLOCK> <DESIGN_PHASE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
setenv DVC_CSH $DOP_HOME/dvc/csh
setenv DVC_ETC $DOP_HOME/dvc/etc
source $DVC_CSH/11_get_svn.csh
source $DVC_CSH/14_get_version.csh

if (($1 != "") && ($1 != ".")) then
   setenv DESIGN_BLOCK $1
   echo "PARA: DESIGN_BLOCK = $DESIGN_BLOCK"
endif

if (($2 != "") && ($2 != ".")) then
    setenv DESIGN_PHASE $1
    echo "PARA: DESIGN_PHASE = $DESIGN_PHASE"
endif


setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$DESIGN_PHASE
setenv BLOCK_URL $PHASE_URL/$DESIGN_BLOCK
svn info $BLOCK_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Block : $DESIGN_BLOCK"
   exit 1
endif

#svn info $BLOCK_URL
echo "URL: $BLOCK_URL"
echo "------------------------------------------------------------"
svn list $BLOCK_URL -v

exit 0
