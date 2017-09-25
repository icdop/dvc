#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DVC_PATH>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/04_set_design.csh

setenv DVC_PATH $phase/$block/$stage/$version
echo "INFO: DVC_PATH = $DVC_PATH"

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT

if (($phase != "") && ($phase != ":") && ($phase != ".")) then
#setenv PHASE_URL $PROJT_URL/$phase
#svn info $PHASE_URL >& /dev/null
#if ($status != 0) then
   $CSH_DIR/21_create_phase.csh $phase
#endif
endif

if (($block != "") && ($block != ":") && ($block != ".")) then
#setenv BLOCK_URL $PROJT_URL/$DESIGN_PHASE/$block
#svn info $BLOCK_URL >& /dev/null
#if ($status != 0) then
   $CSH_DIR/22_create_block.csh $block
#endif
endif

if (($stage != "") && ($stage != ":") && ($stage != ".")) then
#setenv STAGE_URL $PROJT_URL/$DESIGN_PHASE/$DESIGN_BLOCK/$stage
#svn info $STAGE_URL >& /dev/null
#if ($status != 0) then
   $CSH_DIR/23_create_stage.csh $stage
#endif
endif

if (($version != "") && ($version != ":") && ($version != ".")) then
#setenv VERSN_URL $PROJT_URL/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$version
#svn info $VERSN_URL >& /dev/null
#if ($status != 0) then
   $CSH_DIR/24_create_version.csh $version
#else
#   echo "INFO: Exist Project Design Version : $version"
#   if ($?info_mode) then
#      svn info $VERSN_URL
#   endif
#endif
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
