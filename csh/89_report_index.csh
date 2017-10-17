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
setenv CSH_DIR $DVC_HOME/csh
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh
source $CSH_DIR/18_get_report.csh

set project = $DESIGN_PROJT

set dvc_title  = "DVC Database Index"
set main_htm   = ".htm/index.htm"
set main_css   = ".htm/index.css"
(source $html_templ/main/_index_begin.csh) >  $main_htm
(source $html_templ/main/_index_data.csh)  >> $main_htm
(source $html_templ/main/_index_end.csh) >> $main_htm

#### PROJECT HTML REPORT
set dvc_title   = "Project Design Data"
set dvc_name    = $DESIGN_PROJT
set dvc_path    = ""
set dvc_data    = $PROJT_ROOT

set project_htm = "$PROJT_ROOT/.htm/index.htm"
set project_css = "$PROJT_ROOT/.htm/index.css"
cp $html_templ/project/index.css $project_css
(source $html_templ/project/_index_begin.csh) >  $project_htm
(source $html_templ/project/_index_data.csh)  >> $project_htm
(source $html_templ/project/_table_begin.csh) >> $project_htm

set phase_list   = `dir $dvc_data`
#echo "PHASE_LIST $phase_list"
foreach phase ( $phase_list )
  set item_name=$phase
  set item_path=""
  set item_data=$PROJT_ROOT/$item_path/$item_name
  if ($phase != "_") then
  if {(test -d $item_data)} then
     echo "PHASE   : $phase"
     (source $html_templ/project/_table_data.csh) >> $project_htm

     #### PHASE HTML REPORT
     
     set dvc_title = "Phase $phase summary report"
     set dvc_name = $phase
     set dvc_path = $dvc_name
     set dvc_data = $PROJT_ROOT/$dvc_path

     set phase_htm  = $dvc_data/.htm/index.htm
     set phase_css  = $dvc_data/.htm/index.css
     cp $html_templ/phase/index.css $phase_css
    (source $html_templ/phase/_index_begin.csh) >  $phase_htm
    (source $html_templ/phase/_index_data.csh)  >> $phase_htm
    (source $html_templ/phase/_table_begin.csh) >> $phase_htm
     set block_list   = `dir $dvc_data`
     #echo "BLOCK_LIST $block_list"
     foreach block ( $block_list )
        set item_name=$block
        set item_path=$phase 
        set item_data=$PROJT_ROOT/$item_path/$item_name
        if ($block != "_") then
        if {(test -d $item_data)} then
           echo "	BLOCK   : $block"
           (source $html_templ/block/_table_data.csh) >> $phase_htm

           #### BLOCK HTML REPORT
           set dvc_title = "Block $block summary reprot"
           set dvc_name = $block
           set dvc_path = $item_path/$dvc_name
           set dvc_data = $PROJT_ROOT/$dvc_path

           set block_htm   = $dvc_data/.htm/index.htm
           set block_css   = $dvc_data/.htm/index.css
           cp $html_templ/block/index.css $block_css
          (source $html_templ/block/_index_begin.csh) > $block_htm
          (source $html_templ/block/_index_data.csh) >> $block_htm
          (source $html_templ/block/_table_begin.csh)    >> $block_htm
           set stage_list   = `dir $dvc_data`
           #echo "STAGE_LIST $stage_list"
           foreach stage ( $stage_list )
              set item_name=$stage
              set item_path=$phase/$block
              set item_data=$PROJT_ROOT/$item_path/$item_name
              if ($stage != "_") then
              if {(test -d $item_data)} then
                 echo "		STAGE   : $stage"
                 (source $html_templ/block/_table_data.csh) >> $block_htm

                 #### STAGE HTML REPORT
                 set dvc_title = "Stage $stage"
                 set dvc_name = $stage
                 set dvc_path = $item_path/$dvc_name
                 set dvc_data = $PROJT_ROOT/$dvc_path
                 set stage_htm   = $dvc_data/.htm/index.htm
                 set stage_css   = $dvc_data/.htm/index.css
                 cp $html_templ/stage/index.css $stage_css
                (source $html_templ/stage/_index_begin.csh) > $stage_htm
                (source $html_templ/stage/_index_data.csh) >> $stage_htm
                (source $html_templ/stage/_table_begin.csh)    >> $stage_htm
                 set version_list   = `dir $dvc_data`
                 #echo "VERSN_LIST $version_list"
                 foreach version ( $version_list )
                    set item_name=$version
                    set item_path=$phase/$block/$stage
                    set item_data=$PROJT_ROOT/$item_path/$item_name
                    if ($version != "_") then
                    if {(test -d $item_data)} then
                       echo "			VERSION : $version"
                       (source $html_templ/stage/_table_data.csh) >> $stage_htm
                       
                       #### VERSION HTML REPORT
                       set dvc_title = "Version $version"
                       set dvc_name = $version
                       set dvc_path = $item_path/$dvc_name
                       set dvc_data = $PROJT_ROOT/$dvc_path
                       set version_htm   = $dvc_data/.htm/index.htm
                       set version_css   = $dvc_data/.htm/index.css
                       cp $html_templ/version/index.css $version_css
                       
                      (source $html_templ/version/_index_begin.csh) >  $version_htm
                      (source $html_templ/version/_index_data.csh)  >> $version_htm
                      (source $html_templ/version/_table_begin.csh) >> $version_htm
                       set container_list   = `dir $dvc_data`
                       #echo "CONTAINER_LIST: $container_list"
                       foreach container ( $container_list )
                          set item_name=$container
                          set item_path=$phase/$block/$stage/$version
                          set item_data=$PROJT_ROOT/$item_path/$item_name
                          if ($container != "_") then
                          if {(test -d $item_data)} then
                             echo "				CONTAINER : $container"
                             (source $html_templ/version/_table_data.csh) >> $version_htm

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
                                   #echo "					OBJECT  : $object"
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
                       end
                      (source $html_templ/version/_table_end.csh) >> $version_htm
                      (source $html_templ/version/_index_end.csh) >> $version_htm
                    endif
                    endif
                 end
                 (source $html_templ/stage/_table_end.csh) >> $stage_htm
                 (source $html_templ/stage/_index_end.csh) >> $stage_htm
              endif
              endif
           end
           (source $html_templ/block/_table_end.csh) >> $block_htm
           (source $html_templ/block/_index_end.csh) >> $block_htm
        endif
        endif
     end
     (source $html_templ/phase/_table_end.csh) >> $phase_htm
     (source $html_templ/phase/_index_end.csh) >> $phase_htm
   endif
  endif 
end
(source $html_templ/project/_table_end.csh) >> $project_htm
(source $html_templ/project/_index_end.csh) >> $project_htm


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
