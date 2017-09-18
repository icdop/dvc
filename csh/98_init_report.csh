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

setenv DVC_PATH ""

cp $ETC_DIR/css/index.css $CURR_PROJT/.dvc/index.css

set project_idx="$CURR_PROJT/.dvc/index.htm"
echo "<html>" > $project_idx
echo "<head>" >> $project_idx
echo "<title>Project Index Table : $DESIGN_PROJT </title>" >> $project_idx
echo '<link rel="stylesheet" type="text/css" href="index.css" > '>> $project_idx 
eval $cmd_get_css >> $project_idx 
echo "</head>" >> $project_idx
echo "<body>" >> $project_idx
(source $ETC_DIR/html/project_report.csh)   >> $project_idx
(source $ETC_DIR/html/phase_begin.csh)   >> $project_idx
#set phase_list=`$CSH_DIR/40_list_project.csh`
set phase_list=`dir $CURR_PROJT`
foreach dir ($phase_list)
  if ($dir != ":") then
     set phase=$dir:h
#    $CSH_DIR/30_checkout_phase.csh $phase
     if {(test -e $CURR_PROJT/$phase/.dvc)} then
        echo "Phase : $phase"
        if ($phase == $DESIGN_PHASE) then
           set marker="*"
        else 
           set market=""
        endif
        (source $ETC_DIR/html/phase_data.csh) >> $project_idx
     endif
  endif 
end
(source $ETC_DIR/html/phase_end.csh) >> $project_idx
echo "<p>Report created by $USER @ `date`</p>" >> $project_idx
echo "</body>" >> $project_idx
echo "</html>" >> $project_idx


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
