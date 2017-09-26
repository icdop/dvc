#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_VERSN>"
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
source $CSH_DIR/15_get_container.csh
source $CSH_DIR/18_get_report.csh

set project = $DESIGN_PROJT
set phase   = $DESIGN_PHASE
set block   = $DESIGN_BLOCK
set stage   = $DESIGN_STAGE
set version = $DESIGN_VERSN
set container = $DESIGN_CONTR

if ($1 != "") then
   if (($1 != ":") && ($1 != ".")) then
      set container = $1
    endif
    shift argv
endif
                       
echo "CONTAINER : $container"

set dvc_title = "Container $container"
set dvc_name = $container
set dvc_path = $phase/$block/$stage/$version/$dvc_name
set dvc_data = $PROJT_ROOT/$dvc_path

if {(test -d $dvc_data)} then
  set container_htm   = $dvc_data/index.htm
  set container_css   = $dvc_data/.index.css
  cp $html_templ/container/index.css $container_css
else
  echo "ERROR: container data folder '$dvc_data' does not exist"
  exit 1
endif
 
(source $html_templ/container/_index_begin.csh) >  $container_htm
(source $html_templ/container/_index_data.csh)  >> $container_htm
set detail_list = `glob $html_templ/container/_index_detail_*.csh`
foreach detail_report ( $detail_list )
  set id = $detail_report:t:r
  echo "<details id=$id>" >> $container_htm
  (source $detail_report)  >> $container_htm
  echo "</details>" >> $container_htm
end
echo "<details id=object_list open=true>" >> $container_htm
echo "<summary> Object List </summary>" >> $stage_htm
(source $html_templ/container/_table_begin.csh) >> $container_htm
set object_list   = `dir $dvc_data`
#echo "OBJECT_LIST: $object_list"
foreach object ( $object_list )
   set item_name=$object
   set item_path=$phase/$block/$stage/$version/$container
   set item_data=$PROJT_ROOT/$item_path/$item_name
   if ($object != ":") then
   if {(test -d $item_data)} then
      $(CSH_DIR)/85_report_container --html $(html_templ) $container/$object
   else if {(test -e $item_data)} then
      echo "		OBJECT  : $object"
      (source $html_templ/container/_table_data.csh) >> $container_htm
      #### OBJECT HTML REPORT
      set dvc_name = $object
      set dvc_path = $item_path/$dvc_name
      set dvc_data = $PROJT_ROOT/$dvc_path
   endif
   endif
end
(source $html_templ/container/_table_end.csh) >> $container_htm
echo "</details>" >> $container_htm
(source $html_templ/container/_index_end.csh) >> $container_htm

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
