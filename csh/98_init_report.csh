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

$CSH_DIR/30_checkout_project.csh $DESIGN_PROJT
svn checkout --force $PROJT_URL/.dvc $CURR_PROJT/.dvc --depth immediates

set phase_list=`$CSH_DIR/40_list_project.csh $DESIGN_PROJT`
if ($status != 0) then
   echo "ERROR: Can access project folder: $DESIGN_PROJT"
   exit 1
endif

set idxhtml="$CURR_PROJT/.dvc/index.htm"
if {(test -e $idxhtml)} then
   set idx_exist=1
else
   set idxhtml=`mktemp`
endif

set dvcpath=$DESIGN_PROJT
set project=$DESIGN_PROJT

echo "<html>" > $idxhtml
echo "<head>" >> $idxhtml
echo "<title>Project Index Table : $DESIGN_PROJT </title>" >> $idxhtml
echo '<link rel="stylesheet" type="text/css" href="css/index.css" > '>> $idxhtml 
eval $cmd_get_css >> $idxhtml 
echo "</head>" >> $idxhtml

echo "<body>" >> $idxhtml
echo "<table id=indextable>" >> $idxhtml

(source $ETC_DIR/html/title_dvcpath.htm)  >> $idxhtml
(source $ETC_DIR/html/title_project.htm)   >> $idxhtml
(source $ETC_DIR/html/table_project.htm) >> $idxhtml
(source $ETC_DIR/html/title_phase.htm)   >> $idxhtml
foreach dir ($phase_list)
    set phase=$dir:h
    echo "Phase : $phase"
    (source $ETC_DIR/html/table_phase.htm) >> $idxhtml
end
echo "</table>" >> $idxhtml
echo "<p>Report created by $USER @ `date`</p>" >> $idxhtml
echo "</body>" >> $idxhtml
echo "</html>" >> $idxhtml


echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
