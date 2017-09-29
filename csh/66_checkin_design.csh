#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN>"
   exit 1
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

if (($phase != "") && ($phase != "_") && ($phase != ":") && ($phase != ".")) then
   $CSH_DIR/61_checkin_phase.csh $phase
   setenv DESIGN_PHASE $phase
endif

if (($block != "") && ($block != "_") && ($block != ":") && ($block != ".")) then
   $CSH_DIR/62_checkin_block.csh $block
   setenv DESIGN_BLOCK $block
endif

if (($stage != "") && ($stage != "_") && ($stage != ":") && ($stage != ".")) then
   $CSH_DIR/63_checkin_stage.csh $stage
   setenv DESIGN_STAGE $stage
endif

if (($version != "") && ($version != "_") && ($version != ":") && ($version != ".")) then
   $CSH_DIR/64_checkin_version.csh $version
   setenv DESIGN_VERSN $version
   $CSH_DIR/65_checkin_container.csh .
   setenv DESIGN_CONTR .
   
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
