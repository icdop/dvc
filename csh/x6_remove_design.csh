#!/bin/csh -f
set prog=$0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DVC_PATH>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
source $DVC_HOME/csh/12_get_server.csh
source $DVC_HOME/csh/13_get_project.csh
source $DVC_HOME/csh/04_set_design.csh

if ($phase == "") || ($phase == ":" || ($phase == ".") then
   set phase $DESIGN_PHASE
endif

if ($block == "") || ($block == ":" || ($block == ".") then
   set block $DESIGN_BLOCK
endif

if ($stage == "") || ($stage == ":" || ($stage == ".") then
   set stage $DESIGN_STAGE
endif

if ($version == "") || ($version == ":" || ($version == ".") then
   set version $DESIGN_VERSN
endif

setenv DVC_PATH $phase/$block/$stage/$version

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
setenv PHASE_URL $PROJT_URL/$phase
setenv BLOCK_URL $PHASE_URL/$block
setenv STAGE_URL $BLOCK_URL/$stage
setenv VERSN_URL $STAGE_URL/$version

svn info $VERSN_URL >& /dev/null
if ($status == 0) then
   echo "INFO: Remove Project Design Version - $DVC_PATH"
   svn remove $VERSN_URL -m "Remove Design Version $version"
else
   echo "ERROR: Can not find Design Version - $DVC_PATH"
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
