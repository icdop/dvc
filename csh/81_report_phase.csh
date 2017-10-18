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
      set phase = $1
    endif
    shift argv
endif
                       
echo "PHASE : $phase"

set dvc_title = "Phase $phase"
set dvc_name = $phase
set dvc_path = $phase
set dvc_data = $PROJT_ROOT/$dvc_path

if {(test -d $dvc_data)} then
  set phase_htm   = $dvc_data/index.htm
  set phase_css   = $dvc_data/.htm/index.css
  mkdir -p $dvc_data/.htm
  cp $html_templ/phase/index.css $phase_css
else
  echo "ERROR: phase data folder '$dvc_data' does not exist"
  exit 1
endif
(source $html_templ/phase/_index_begin.csh) >  $phase_htm
(source $html_templ/phase/_index_data.csh)  >> $phase_htm
set detail_list = `glob $html_templ/phase/_index_detail_*.csh`
foreach detail_report ( $detail_list )
  set id = $detail_report:t:r
  echo "<details id=$id>" >> $phase_htm
  (source $detail_report)  >> $phase_htm
  echo "</details>" >> $phase_htm
end
echo "<details id=block_list open=true>" >> $phase_htm
echo "<summary> Block List </summary>" >> $phase_htm
(source $html_templ/phase/_table_begin.csh) >> $phase_htm
 set block_list   = `dir $dvc_data`
 foreach block ( $block_list )
    set item_name=$block
    set item_path=$phase
    set item_data=$PROJT_ROOT/$item_path/$item_name
    if ($item_name != "_") then
    if {(test -d $item_data)} then
       echo "	BLOCK : $block"
       (source $html_templ/phase/_table_data.csh) >> $phase_htm
    endif
    endif
 end
(source $html_templ/phase/_table_end.csh) >> $phase_htm
echo "</details>" >> $phase_htm
(source $html_templ/phase/_index_end.csh) >> $phase_htm

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
