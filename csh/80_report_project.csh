#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_PROJT>"
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
      set project = $1
    endif
    shift argv
endif
                       
echo "PROJECT : $project"

set dvc_title = "Project $project"
set dvc_name = $project
set dvc_path = ..
set dvc_data = $PROJT_ROOT

if {(test -d $dvc_data)} then
  set project_htm   = $dvc_data/.htm/index.htm
  set project_css   = $dvc_data/.htm/index.css
  cp $html_templ/project/index.css $project_css
else
  echo "ERROR: project data folder '$dvc_data' does not exist"
  exit 1
endif
(source $html_templ/project/_index_begin.csh) >  $project_htm
(source $html_templ/project/_index_data.csh)  >> $project_htm
set detail_list = `glob $html_templ/project/_index_detail_*.csh`
foreach detail_report ( $detail_list )
  set id = $detail_report:t:r
  echo "<details id=$id>" >> $project_htm
  (source $detail_report)  >> $project_htm
  echo "</details>" >> $project_htm
end
echo "<details id=phase_list open=true>" >> $project_htm
echo "<summary> Phase List </summary>" >> $project_htm
(source $html_templ/project/_table_begin.csh) >> $project_htm
 set phase_list   = `dir $dvc_data`
 foreach phase ( $phase_list )
    set item_name = $phase
    set item_path = .
    set item_data = $PROJT_ROOT/$item_path/$item_name
    if ($item_name != "_") then
    if {(test -d $item_data)} then
       echo "	PHASE : $phase"
       (source $html_templ/project/_table_data.csh) >> $project_htm
    endif
    endif
 end
(source $html_templ/project/_table_end.csh) >> $project_htm
echo "</details>" >> $project_htm
(source $html_templ/project/_index_end.csh) >> $project_htm

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
