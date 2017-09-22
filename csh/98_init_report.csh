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
source $CSH_DIR/08_set_report.csh

if ($?report_index) then
   set project=$report_index
else
   set project=$DESIGN_PROJT
endif

if ($?html_templ) then
   setenv HTM_DIR $htmp_temp
else
   setenv HTM_DIR $ETC_DIR/html
endif

set dvc_title  = "DVC Database Index"
set main_htm   = "index.htm"
set main_css   = ".index.css"
(source $HTM_DIR/main/_index_begin.csh) >  $main_htm
(source $HTM_DIR/main/_index_data.csh)  >> $main_htm
(source $HTM_DIR/main/_index_end.csh) >> $main_htm

#### PROJECT HTML REPORT
set dvc_title   = "Project $project Design Data"
set dvc_name    = $project
set dvc_path    = ""
set dvc_data    = $CURR_PROJT

set project_htm = "$CURR_PROJT/index.htm"
set project_css = "$CURR_PROJT/.index.css"
cp $HTM_DIR/project/index.css $project_css
(source $HTM_DIR/project/_index_begin.csh) >  $project_htm
(source $HTM_DIR/project/_index_data.csh)  >> $project_htm
(source $HTM_DIR/project/_table_begin.csh) >> $project_htm

set phase_list   = `dir $dvc_data`
#echo "PHASE_LIST $phase_list"
foreach phase ( $phase_list )
  set item_name=$phase
  set item_path=""
  set item_data=$CURR_PROJT/$item_path/$item_name
  if ($phase != ":") then
  if {(test -d $item_data)} then
     echo "PHASE   : $phase"
     (source $HTM_DIR/project/_table_data.csh) >> $project_htm

     #### PHASE HTML REPORT
     
     set dvc_title = "Phase $phase summary report"
     set dvc_name = $phase
     set dvc_path = $dvc_name
     set dvc_data = $CURR_PROJT/$dvc_path

     set phase_htm  = $dvc_data/index.htm
     set phase_css  = $dvc_data/.index.css
     cp $HTM_DIR/phase/index.css $phase_css
    (source $HTM_DIR/phase/_index_begin.csh) >  $phase_htm
    (source $HTM_DIR/phase/_index_data.csh)  >> $phase_htm
    (source $HTM_DIR/phase/_table_begin.csh) >> $phase_htm
     set block_list   = `dir $dvc_data`
     #echo "BLOCK_LIST $block_list"
     foreach block ( $block_list )
        set item_name=$block
        set item_path=$phase 
        set item_data=$CURR_PROJT/$item_path/$item_name
        if ($block != ":") then
        if {(test -d $item_data)} then
           echo "	BLOCK   : $block"
           (source $HTM_DIR/block/_table_data.csh) >> $phase_htm

           #### BLOCK HTML REPORT
           set dvc_title = "Block $block summary reprot"
           set dvc_name = $block
           set dvc_path = $item_path/$dvc_name
           set dvc_data = $CURR_PROJT/$dvc_path

           set block_htm   = $dvc_data/index.htm
           set block_css   = $dvc_data/.index.css
           cp $HTM_DIR/block/index.css $block_css
          (source $HTM_DIR/block/_index_begin.csh) > $block_htm
          (source $HTM_DIR/block/_index_data.csh) >> $block_htm
          (source $HTM_DIR/block/_table_begin.csh)    >> $block_htm
           set stage_list   = `dir $dvc_data`
           #echo "STAGE_LIST $stage_list"
           foreach stage ( $stage_list )
              set item_name=$stage
              set item_path=$phase/$block
              set item_data=$CURR_PROJT/$item_path/$item_name
              if ($stage != ":") then
              if {(test -d $item_data)} then
                 echo "		STAGE   : $stage"
                 (source $HTM_DIR/block/_table_data.csh) >> $block_htm

                 #### STAGE HTML REPORT
                 set dvc_title = "Stage $stage"
                 set dvc_name = $stage
                 set dvc_path = $item_path/$dvc_name
                 set dvc_data = $CURR_PROJT/$dvc_path
                 set stage_htm   = $dvc_data/index.htm
                 set stage_css   = $dvc_data/.index.css
                 cp $HTM_DIR/stage/index.css $stage_css
                (source $HTM_DIR/stage/_index_begin.csh) > $stage_htm
                (source $HTM_DIR/stage/_index_data.csh) >> $stage_htm
                (source $HTM_DIR/stage/_table_begin.csh)    >> $stage_htm
                 set version_list   = `dir $dvc_data`
                 #echo "VERSN_LIST $version_list"
                 foreach version ( $version_list )
                    set item_name=$version
                    set item_path=$phase/$block/$stage
                    set item_data=$CURR_PROJT/$item_path/$item_name
                    if ($version != ":") then
                    if {(test -d $item_data)} then
                       echo "			VERSION : $version"
                       (source $HTM_DIR/stage/_table_data.csh) >> $stage_htm
                       
                       #### VERSION HTML REPORT
                       set dvc_title = "Version $version"
                       set dvc_name = $version
                       set dvc_path = $item_path/$dvc_name
                       set dvc_data = $CURR_PROJT/$dvc_path
                       set version_htm   = $dvc_data/index.htm
                       set version_css   = $dvc_data/.index.css
                       cp $HTM_DIR/version/index.css $version_css
                       
                      (source $HTM_DIR/version/_index_begin.csh) >  $version_htm
                      (source $HTM_DIR/version/_index_data.csh)  >> $version_htm
                      (source $HTM_DIR/version/_table_begin.csh) >> $version_htm
                       set container_list   = `dir $dvc_data`
                       #echo "CONTAINER_LIST: $container_list"
                       foreach container ( $container_list )
                          set item_name=$container
                          set item_path=$phase/$block/$stage/$version
                          set item_data=$CURR_PROJT/$item_path/$item_name
                          if ($container != ":") then
                          if {(test -d $item_data)} then
                             echo "				CONTAINER : $container"
                             (source $HTM_DIR/version/_table_data.csh) >> $version_htm

                             #### CONTAINER HTML REPORT
                             set dvc_title = "Container $container"
                             set dvc_name = $container
                             set dvc_path = $item_path/$dvc_name
                             set dvc_data = $CURR_PROJT/$dvc_path
                             set container_htm   = $dvc_data/index.htm
                             set container_css   = $dvc_data/.index.css
                             cp $HTM_DIR/container/index.css $container_css
                            (source $HTM_DIR/container/_index_begin.csh) >  $container_htm
                            (source $HTM_DIR/container/_index_data.csh)  >> $container_htm
                            (source $HTM_DIR/container/_table_begin.csh) >> $container_htm
                             set object_list   = `dir $dvc_data`
                             #echo "OBJECT_LIST: $object_list"
                             foreach object ( $object_list )
                                set item_name=$object
                                set item_path=$phase/$block/$stage/$version/$container
                                set item_data=$CURR_PROJT/$item_path/$item_name
                                if ($object != ":") then
                                if {(test -e $item_data)} then
                                   echo "					OBJECT  : $object"
                                   (source $HTM_DIR/container/_table_data.csh) >> $container_htm
                                   #### OBJECT HTML REPORT
                                   set dvc_name = $object
                                   set dvc_path = $item_path/$dvc_name
                                   set dvc_data = $CURR_PROJT/$dvc_path
                                endif
                                endif
                             end
                            (source $HTM_DIR/container/_table_end.csh) >> $container_htm
                            (source $HTM_DIR/container/_index_end.csh) >> $container_htm
                         endif
                         endif
                       end
                      (source $HTM_DIR/version/_table_end.csh) >> $version_htm
                      (source $HTM_DIR/version/_index_end.csh) >> $version_htm
                    endif
                    endif
                 end
                 (source $HTM_DIR/stage/_table_end.csh) >> $stage_htm
                 (source $HTM_DIR/stage/_index_end.csh) >> $stage_htm
              endif
              endif
           end
           (source $HTM_DIR/block/_table_end.csh) >> $block_htm
           (source $HTM_DIR/block/_index_end.csh) >> $block_htm
        endif
        endif
     end
     (source $HTM_DIR/phase/_table_end.csh) >> $phase_htm
     (source $HTM_DIR/phase/_index_end.csh) >> $phase_htm
   endif
  endif 
end
(source $HTM_DIR/project/_table_end.csh) >> $project_htm
(source $HTM_DIR/project/_index_end.csh) >> $project_htm


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
