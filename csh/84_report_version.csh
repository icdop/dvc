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
source $CSH_DIR/18_get_report.csh

set project = $DESIGN_PROJT
set phase   = $DESIGN_PHASE
set block   = $DESIGN_BLOCK
set stage   = $DESIGN_STAGE
set version = $DESIGN_VERSN

if ($1 != "") then
   if (($1 != "_") && ($1 != ".")) then
      set version = $1
    endif
    shift argv
endif
                       
echo "VERSION : $version"

set dvc_title = "Version $version"
set dvc_name = $version
set dvc_path = $phase/$block/$stage/$version
set dvc_data = $PROJT_ROOT/$dvc_path

if {(test -d $dvc_data)} then
else
  echo "ERROR: version data folder '$dvc_data' does not exist"
  exit 1
endif
set version_htm   = $dvc_data/,htm/index.htm
set version_css   = $dvc_data/.htm/index.css
cp $html_templ/version/index.css $version_css
 
(source $html_templ/version/_index_begin.csh) >  $version_htm
(source $html_templ/version/_index_data.csh)  >> $version_htm
set detail_list = `glob $html_templ/version/_index_detail_*.csh`
foreach detail_report ( $detail_list )
  set id = $detail_report:t:r
  echo "<details id=$id>" >> $version_htm
  (source $detail_report)  >> $version_htm
  echo "</details>" >> $version_htm
end
echo "<details id=container_list open=true>" >> $version_htm
echo "<summary> Container List </summary>" >> $version_htm
(source $html_templ/version/_table_begin.csh) >> $version_htm
 set container_list   = `dir $dvc_data`
 #echo "CONTAINER_LIST: $container_list"
 foreach container ( $container_list )
    set item_name=$container
    set item_path=$phase/$block/$stage/$version
    set item_data=$PROJT_ROOT/$item_path/$item_name
    if ($container != "_") then
    if {(test -d $item_data)} then
       echo "	CONTAINER : $container"
       (source $html_templ/version/_table_data.csh) >> $version_htm
       
       if {(test -d $html_templ/container/)} then
       #### CONTAINER HTML REPORT
       set dvc_title = "Container $container"
       set dvc_name = $container
       set dvc_path = $item_path/$dvc_name
       set dvc_data = $PROJT_ROOT/$dvc_path
       set container_htm   = $dvc_data/.htm/index.htm
       set container_css   = $dvc_data/.htm/index.css
       cp $html_templ/container/index.css $container_css
      (source $html_templ/container/_index_begin.csh) >  $container_htm
      (source $html_templ/container/_index_data.csh)  >> $container_htm
      (source $html_templ/container/_table_begin.csh) >> $container_htm
       set object_list   = `dir $dvc_data`
       #echo "OBJECT_LIST: $object_list"
       foreach object ( $object_list )
          set item_name=$object
          set item_path=$phase/$block/$stage/$version/$container
          set item_data=$PROJT_ROOT/$item_path/$item_name
          if {(test -e $item_data)} then
             echo "		OBJECT  : $object"
             (source $html_templ/container/_table_data.csh) >> $container_htm
             #### OBJECT HTML REPORT
             set dvc_name = $object
             set dvc_path = $item_path/$dvc_name
             set dvc_data = $PROJT_ROOT/$dvc_path
          endif
       end
      (source $html_templ/container/_table_end.csh) >> $container_htm
      (source $html_templ/container/_index_end.csh) >> $container_htm
       endif
   endif
   endif
 end
(source $html_templ/version/_table_end.csh) >> $version_htm
echo "</details>" >> $version_htm
(source $html_templ/version/_index_end.csh) >> $version_htm

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
