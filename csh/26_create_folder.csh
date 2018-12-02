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
source $CSH_DIR/19_get_system.csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/04_set_folder.csh

setenv DVC_PATH $block/$phase/$stage/$version
echo "INFO: DVC_PATH = $DVC_PATH"

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT

if (($block != "") && ($block != "_") && ($block != ":") && ($block != ".")) then
   if ($?force_mode) then
      $CSH_DIR/21_create_block.csh --force $block
   else
      $CSH_DIR/21_create_block.csh $block
   endif
   setenv DESIGN_BLOCK $block
endif

if (($phase != "") && ($phase != "_") && ($phase != ":") && ($phase != ".")) then
   if ($?force_mode) then
      $CSH_DIR/22_create_phase.csh --force $phase
   else
      $CSH_DIR/22_create_phase.csh $phase
   endif
   setenv DESIGN_PHASE $phase
endif

if (($stage != "") && ($stage != "_") && ($stage != ":") && ($stage != ".")) then
   if ($?force_mode) then
      $CSH_DIR/23_create_stage.csh --force $stage
   else
      $CSH_DIR/23_create_stage.csh $stage
   endif
   setenv DESIGN_STAGE $stage
endif

if (($version != "") && ($version != "_") && ($version != ":") && ($version != ".")) then
   if ($?force_mode) then
      $CSH_DIR/24_create_version.csh --force $version
   else
      $CSH_DIR/24_create_version.csh $version
   endif
   setenv DESIGN_VERSN $version
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
