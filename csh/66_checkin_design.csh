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

if (($phase != "") && ($phase != ":") && ($phase != ".")) then
   $CSH_DIR/61_checkin_phase.csh $phase
endif

if (($block != "") && ($block != ":") && ($block != ".")) then
   $CSH_DIR/62_checkin_block.csh $block
endif

if (($stage != "") && ($stage != ":") && ($stage != ".")) then
   $CSH_DIR/63_checkin_stage.csh $stage
endif

if (($version != "") && ($version != ":") && ($version != ".")) then
   $CSH_DIR/64_checkin_version.csh $version
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
