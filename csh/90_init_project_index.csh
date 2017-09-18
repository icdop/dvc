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
source $CSH_DIR/03_set_project.csh

set cmd_get_css = ""
if ($1 == "-css") then
   shift argv
   if ($1 != "") then
     set css_file=$1
     shift argv
     if (test -e $css_file)) then
        set cmd_get_css = "cat $1"
     endif
   endif
endif

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
svn info $PROJT_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Can not find Project Design Respository : $DESIGN_PROJT"
   exit 1
endif

set phase_list=`$CSH_DIR/40_list_project.csh $DESIGN_PROJT`
if ($status != 0) then
   echo "ERROR: Can access project folder: $DESIGN_PROJT"
   exit 1
endif

cp $ETC_DIR/css/index.css $CURR_PROJT/.dvc/index.css
set idxhtml="$CURR_PROJT/.dvc/index.htm"
if {(test -e $idxhtml)} then
   set idx_exist=1
else
   set idxhtml=`mktemp`
endif

echo "<html>" > $idxhtml
echo "<head>" >> $idxhtml
echo "<title>Project Index Table : $DESIGN_PROJT </title>" >> $idxhtml
echo '<link rel="stylesheet" type="text/css" href="index.css" > '>> $idxhtml 
eval $cmd_get_css >> $idxhtml 
echo "</head>" >> $idxhtml

echo "<body>" >> $idxhtml
echo "<table id=indextable>" >> $idxhtml
echo "<tr class=header><td colspan=3><h2>dvc://$DESIGN_PROJT/</h2></td></tr>" >> $idxhtml
echo "<tr>" >> $idxhtml
echo "<tr class=title><td><b>PROJECT</b></td><td><b>README</b></td><td><b>SUMMARY</b></td></tr>" >> $idxhtml
echo "<td class=col1>$DESIGN_PROJT</td>" >> $idxhtml
echo "<td class=col2><pre>" >> $idxhtml
echo '<object name="readme" type="text/html" data="README"></object>'>> $idxhtml
echo "</pre></td>" >> $idxhtml
echo "<td class=col3> </td>" >> $idxhtml
echo "</tr>" >> $idxhtml

echo "<tr class=title><td><b>PHASE</b></td><td><b>README</b></td><td><b>STATUS</b></td></tr>" >> $idxhtml
foreach dir ($phase_list)
    set phase=$dir:h
    echo "Phase : $phase"
    echo "<tr class=data>" >> $idxhtml
    echo "<td class=col1> <a href=../$phase/.dvc/index.htm> $phase </a></td>" >> $idxhtml
    echo "<td class=col2><pre>" >> $idxhtml
    svn cat $PROJT_URL/$phase/.dvc/README >> $idxhtml
    echo "</pre></td>" >> $idxhtml
    echo "<td class=col3><pre>" >> $idxhtml
    echo '<object name="summary" type="text/html" data="../$phase/.dvc/DESIGN_FILES"></object>'>> $idxhtml
    echo "</pre></td></tr>" >> $idxhtml
end
echo "</table>" >> $idxhtml
echo "<p>Table created by $USER @ `date`</p>" >> $idxhtml
echo "</body>" >> $idxhtml
echo "</html>" >> $idxhtml

if ($?idx_exist) then
   svn commit --quiet $idxhtml -m 'Directory Index' 
else
   svn info $PROJT_URL/.dvc/index.htm >& /dev/null
   if ($status == 0) then
      svn delete --quiet --force $PROJT_URL/.dvc/index.htm -m 'Delete Index'
   endif
   svn import --quiet --force $idxhtml  $PROJT_URL/.dvc/index.htm -m 'Directory Index' 
   if ($status == 0) then
      if {(test -d $CURR_PROJT/.dvc/)} then
         svn update --quiet $CURR_PROJT/.dvc/
      endif
      rm -f $idxhtml
   else
      mkdir -p $CURR_PROJT/.dvc/
      mv $idxhtml $CURR_PROJT/.dvc/index.htm
   endif
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
