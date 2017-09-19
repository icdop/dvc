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

set project=$DESIGN_PROJT
#rm -fr $CURR_PROJT/.dvc
#$CSH_DIR/30_checkout_project.csh $project
#svn checkout --force $PROJT_URL $CURR_PROJT --depth immediates
#svn checkout --force $PROJT_URL/.dvc $CURR_PROJT/.dvc

set main_idx="index.htm"
(source $ETC_DIR/html/_index.csh) > $main_idx

set project_css="$CURR_PROJT/.dvc/index.css"
cp $ETC_DIR/css/index.css $project_css
if ($?css_file) then
   if {(test -e $css_file)} then
      cat $css_file >> $project_css 
   endif
endif

set report_name = $project
set report_path = ""
set data_path   = $CURR_PROJT
set project_idx="$CURR_PROJT/.dvc/index.htm"
cp $ETC_DIR/css/index.css $data_path/.dvc/index.css
set phase_list   = `dir $data_path`
#echo "PHASE_LIST $phase_list"
(source $ETC_DIR/html/_header.csh) > $project_idx
(source $ETC_DIR/html/_report_project.csh) >> $project_idx
(source $ETC_DIR/html/_table_begin.csh)    >> $project_idx
#set phase_list=`$CSH_DIR/40_list_project.csh`
foreach phase ( $phase_list )
  if ($phase != ":") then
  if {(test -d $CURR_PROJT/$phase/.dvc)} then
     #echo "PHASE   : $phase"
     set curr_name=$phase
     set curr_head=""
     set curr_path=$CURR_PROJT/$phase
     (source $ETC_DIR/html/_table_data.csh) >> $project_idx
     #### PHASE REPORT
     set report_name = $phase
     set report_path = $phase
     set data_path   = $CURR_PROJT/$report_path
     set phase_idx   = $data_path/.dvc/index.htm
     cp $ETC_DIR/css/index.css $data_path/.dvc/index.css
     set block_list   = `dir $data_path`
     #echo "BLOCK_LIST $block_list"
    (source $ETC_DIR/html/_header.csh) > $phase_idx
    (source $ETC_DIR/html/_report.csh) >> $phase_idx
    (source $ETC_DIR/html/_table_begin.csh)    >> $phase_idx
     foreach block ( $block_list )
        if ($block != ":") then
        if {(test -d $CURR_PROJT/$phase/$block/.dvc)} then
           #echo "BLOCK   : $block"
           set curr_name=$block
           set curr_head=$phase
           set curr_path=$CURR_PROJT/$phase/$block
           (source $ETC_DIR/html/_table_data.csh) >> $phase_idx
           #### BLOCK REPORT
           set report_name = $block
           set report_path = $phase/$block
           set data_path   = $CURR_PROJT/$report_path
           set block_idx   = $data_path/.dvc/index.htm
           cp $ETC_DIR/css/index.css $data_path/.dvc/index.css
           set stage_list   = `dir $data_path`
           #echo "STAGE_LIST $stage_list"
          (source $ETC_DIR/html/_header.csh) > $block_idx
          (source $ETC_DIR/html/_report.csh) >> $block_idx
          (source $ETC_DIR/html/_table_begin.csh)    >> $block_idx
           foreach stage ( $stage_list )
              if ($stage != ":") then
              if {(test -d $CURR_PROJT/$phase/$block/$stage/.dvc)} then
                 #echo "STAGE   : $stage"
                 set curr_name=$stage
                 set curr_head=$phase/$block
                 set curr_path=$CURR_PROJT/$phase/$block/$stage
                 (source $ETC_DIR/html/_table_data.csh) >> $block_idx
                 #### STAGE REPORT
                 set report_name = $stage
                 set report_path = $phase/$block/$stage
                 set data_path   = $CURR_PROJT/$report_path
                 set stage_idx   = $data_path/.dvc/index.htm
                 cp $ETC_DIR/css/index.css $data_path/.dvc/index.css
                 set version_list   = `dir $data_path`
                 #echo "VERSN_LIST $version_list"
                (source $ETC_DIR/html/_header.csh) > $stage_idx
                (source $ETC_DIR/html/_report.csh) >> $stage_idx
                (source $ETC_DIR/html/_table_begin.csh)    >> $stage_idx
                 foreach version ( $version_list )
                    if ($version != ":") then
                    if {(test -d $CURR_PROJT/$phase/$block/$stage/$version/.dvc)} then
                       #echo "VERSION : $version"
                       set curr_name=$version
                       set curr_head=$phase/$block/$stage
                       set curr_path=$CURR_PROJT/$phase/$block/$stage/$version
                       (source $ETC_DIR/html/_table_data.csh) >> $stage_idx
                       #### VERSION REPORT
                       set report_name = $version
                       set report_path = $phase/$block/$stage/$version
                       set data_path   = $CURR_PROJT/$report_path
                       set version_idx   = $data_path/.dvc/index.htm
                       cp $ETC_DIR/css/index.css $data_path/.dvc/index.css
                       set container_list   = `dir $data_path`
                       #echo "CONTAINER_LIST: $container_list"
                      (source $ETC_DIR/html/_header.csh) > $version_idx
                      (source $ETC_DIR/html/_report_version.csh) >> $version_idx
                      (source $ETC_DIR/html/_table_container_begin.csh)    >> $version_idx
                       foreach container ( $container_list )
                          if ($container != ":") then
                          if {(test -d $CURR_PROJT/$phase/$block/$stage/$version/$container/.dvc)} then
                             #echo "CONTAINER : $container"
                             set curr_name=$container
                             set curr_head=$phase/$block/$stage/$version
                             set curr_path=$CURR_PROJT/$phase/$block/$stage/$version/$container
                             (source $ETC_DIR/html/_table_container_data.csh) >> $version_idx
                             #### CONTAINER REPORT
                             set report_name = $container
                             set report_path = $phase/$block/$stage/$version/$container
                             set data_path   = $CURR_PROJT/$report_path
                             set container_idx   = $data_path/.dvc/index.htm
                             cp $ETC_DIR/css/index.css $data_path/.dvc/index.css
                             set object_list   = `dir $data_path`
                             #echo "OBJECT_LIST: $object_list"
                            (source $ETC_DIR/html/_header.csh) > $container_idx
                            (source $ETC_DIR/html/_report.csh) >> $container_idx
                            (source $ETC_DIR/html/_table_object_begin.csh)    >> $container_idx
                             foreach object ( $object_list )
                                if ($object != ":") then
                                if {(test -e $CURR_PROJT/$phase/$block/$stage/$version/$container/$object)} then
                                   #echo "OBJECT  : $object"
                                   set curr_name=$object
                                   set curr_head=$phase/$block/$stage/$version/$container
                                   set curr_path=$CURR_PROJT/$phase/$block/$stage/$version/$container/$object
                                   (source $ETC_DIR/html/_table_object_data.csh) >> $container_idx
                                   #### OBJECT REPORT
                                   set report_name = $object
                                   set report_path = $phase/$block/$stage/$version/$container/$object
                                   set data_path   = $CURR_PROJT/$report_path
                                   set object_idx  = $CURR_PROJT/$report_path
                                endif
                                endif
                             end
                            (source $ETC_DIR/html/_table_end.csh) >> $container_idx
                            (source $ETC_DIR/html/_footer.csh) >> $container_idx
                         endif
                         endif
                       end
                      (source $ETC_DIR/html/_table_end.csh) >> $version_idx
                      (source $ETC_DIR/html/_footer.csh) >> $version_idx
                    endif
                    endif
                 end
                 (source $ETC_DIR/html/_table_end.csh) >> $stage_idx
                 (source $ETC_DIR/html/_footer.csh) >> $stage_idx
              endif
              endif
           end
           (source $ETC_DIR/html/_table_end.csh) >> $block_idx
           (source $ETC_DIR/html/_footer.csh) >> $block_idx
        endif
        endif
     end
     (source $ETC_DIR/html/_table_end.csh) >> $phase_idx
     (source $ETC_DIR/html/_footer.csh) >> $phase_idx
   endif
  endif 
end
(source $ETC_DIR/html/_table_end.csh) >> $project_idx
(source $ETC_DIR/html/_footer.csh) >> $project_idx


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
