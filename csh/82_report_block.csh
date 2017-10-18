#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PHASE>"
   exit -1
endif
echo "======================================================="
echo "TIME: @`date +%Y%m%d_%H%M%S` BEGIN $prog $*"

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv ETC_DIR $DVC_HOME/etc
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh
source $CSH_DIR/18_get_report.csh

set project = $DESIGN_PROJT
set phase   = $DESIGN_PHASE
set block   = $DESIGN_BLOCK
set stage   = $DESIGN_STAGE
set version = $DESIGN_VERSN

if ($1 != "") then
   if (($1 != "_") && ($1 != ".")) then
      set block = $1
    endif
    shift argv
endif
                       
echo "BLOCK : $block"

set dvc_title = "Block $block"
set dvc_name = $block
set dvc_path = $phase/$block
set dvc_data = $PROJT_ROOT/$dvc_path

if {(test -d $dvc_data)} then
  set block_htm   = $dvc_data/index.htm
  set block_css   = $dvc_data/.htm/index.css
  mkdir -p $dvc_data/.htm
  cp $html_templ/block/index.css $block_css
else
  echo "ERROR: block data folder '$dvc_data' does not exist"
  exit 1
endif
(source $html_templ/block/_index_begin.csh) >  $block_htm
(source $html_templ/block/_index_data.csh)  >> $block_htm
set detail_list = `glob $html_templ/block/_index_detail_*.csh`
foreach detail_report ( $detail_list )
  set id = $detail_report:t:r
  echo "<details id=$id>" >> $block_htm
  (source $detail_report)  >> $block_htm
  echo "</details>" >> $block_htm
end
echo "<details id=stage_list open=true>" >> $block_htm
echo "<summary> Stage List </summary>" >> $block_htm
(source $html_templ/block/_table_begin.csh) >> $block_htm
 set stage_list   = `dir $dvc_data`
 foreach stage ( $stage_list )
    set item_name=$stage
    set item_path=$phase/$block
    set item_data=$PROJT_ROOT/$item_path/$item_name
    if ($item_name != "_") then
    if {(test -d $item_data)} then
       echo "	STAGE : $stage"
       (source $html_templ/block/_table_data.csh) >> $block_htm
    endif
    endif
 end
(source $html_templ/block/_table_end.csh) >> $block_htm
echo "</details>" >> $block_htm
(source $html_templ/block/_index_end.csh) >> $block_htm

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
