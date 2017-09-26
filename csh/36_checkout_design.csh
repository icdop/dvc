#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DVC_PATH>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/04_set_design.csh

setenv DVC_PATH $phase/$block/$stage/$version
echo "INFO: DVC_PATH = $DVC_PATH"

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT

if (($phase != "") && ($phase != ":") && ($phase != ".")) then
setenv PHASE_URL $PROJT_URL/$phase
svn info $PHASE_URL >& /dev/null
if ($status == 0) then
   $CSH_DIR/31_checkout_phase.csh $phase
   setenv DESIGN_PHASE $phase
else
   echo "ERROR: Cannot find Project Design Phase : $phase"
   exit 1
endif
endif

if (($block != "") && ($block != ":") && ($block != ".")) then
setenv BLOCK_URL $PROJT_URL/$DESIGN_PHASE/$block
svn info $BLOCK_URL >& /dev/null
if ($status == 0) then
   $CSH_DIR/32_checkout_block.csh $block
   setenv DESIGN_BLOCK $block
else
   echo "ERROR: Cannot find Project Design Block : $block"
   exit 1
endif
endif

if (($stage != "") && ($stage != ":") && ($stage != ".")) then
setenv STAGE_URL $PROJT_URL/$DESIGN_PHASE/$DESIGN_BLOCK/$stage
svn info $STAGE_URL >& /dev/null
if ($status == 0) then
   $CSH_DIR/33_checkout_stage.csh $stage
   setenv DESIGN_STAGE $stage
else
   echo "ERROR: Cannot find Project Design Stage : $stage"
   exit 1
endif
endif

if (($version != "") && ($version != ":") && ($version != ".")) then
setenv VERSN_URL $PROJT_URL/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$version
svn info $VERSN_URL >& /dev/null
if ($status == 0) then
   $CSH_DIR/34_checkout_version.csh $version
   setenv DESIGN_VERSN $version
else
   echo "ERROR: Cannot find Project Design Version : $version"
   exit 1
endif
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
