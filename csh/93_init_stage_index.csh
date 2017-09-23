#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_STAGE>"
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
source $CSH_DIR/14_get_version.csh

if ($1 != "") then
   setenv DESIGN_STAGE $1
   shift argv
endif

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

setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE
setenv DESIGN_URL $SVN_URL/$DESIGN_PROJT/$DVC_PATH
svn info $DESIGN_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Can not find path : $DVC_PATH"
   exit 1
endif

set name_list=`$CSH_DIR/43_list_stage.csh $DESIGN_STAGE`
if ($status != 0) then
   echo "ERROR: Can access project folder: $DESIGN_STAGE"
   exit 1
endif

cp $ETC_DIR/css/index.css $PROJT_ROOT/$DVC_PATH/.dvc/index.css
set idxhtml="$PROJT_ROOT/$DVC_PATH/.dvc/index.htm"
if {(test -e $idxhtml)} then
   set idx_exist=1
else
   set idxhtml=`mktemp`
endif

echo "<html>" > $idxhtml
echo "<head>" >> $idxhtml
echo "<title>Index Table - $DVC_PATH </title>" >> $idxhtml
echo '<link rel="stylesheet" type="text/css" href="index.css" > '>> $idxhtml 
eval $cmd_get_css >> $idxhtml 
echo "</head>" >> $idxhtml

echo "<body>" >> $idxhtml
echo "<table id=indextable>" >> $idxhtml
echo "<tr class=header><td colspan=3><h2>dvc://$DESIGN_PROJT/$DVC_PATH</h2></td></tr>" >> $idxhtml
echo "<tr class=title><td><b>STAGE</b></td><td><b>README</b></td><td><b>SUMMARY</b></td></tr>" >> $idxhtml
echo "<tr>" >> $idxhtml
echo "<td class=col1>$DESIGN_STAGE</td>" >> $idxhtml
echo "<td class=col2><pre>" >> $idxhtml
echo '<object name="readme" type="text/html" data="README"></object>'>> $idxhtml
echo "</pre></td>" >> $idxhtml
echo "<td class=col3> </td>" >> $idxhtml
echo "</tr>" >> $idxhtml

echo "<tr class=title><td><b>VERSION</b></td><td><b>README</b></td><td><b>STATUS</b></td></tr>" >> $idxhtml
foreach dir ($name_list)
    set name=$dir:h
    echo "Sub-folder : $name"
    echo "<tr class=data>" >> $idxhtml
    echo "<td class=col1> <a href=../$name/.dvc/index.htm> $name </a></td>" >> $idxhtml
    echo "<td class=col2><pre>" >> $idxhtml
    svn cat $DESIGN_URL/$name/.dvc/README  >> $idxhtml
    echo "</pre></td>" >> $idxhtml
    echo "<td class=col3><pre>" >> $idxhtml
    echo '<object name="summary" type="text/html" data="../$name/.dvc/DESIGN_FILES"></object>'>> $idxhtml
    echo "</pre></td></tr>" >> $idxhtml
end
echo "</table>" >> $idxhtml
echo "<p>Table created by $USER @ `date`</p>" >> $idxhtml
echo "</body>" >> $idxhtml
echo "</html>" >> $idxhtml

if ($?idx_exist) then
   svn commit --quiet  $idxhtml -m 'Update Directory Index' 
else
   svn info $DESIGN_URL/.dvc/index.htm >& /dev/null
   if ($status == 0) then
      svn delete --quiet --force $DESIGN_URL/.dvc/index.htm -m 'Delete Index'
   endif
   svn import --quiet --force $idxhtml  $DESIGN_URL/.dvc/index.htm -m 'Directory Index' 
   if ($status == 0) then
      if {(test -d $PROJT_ROOT/$DVC_PATH/.dvc/)} then
         svn update --quiet $PROJT_ROOT/$DVC_PATH/.dvc/
      endif
      rm -f $idxhtml
   else
      mkdir -p $PROJT_ROOT/$DVC_PATH/.dvc/
      mv $idxhtml $PROJT_ROOT/$DVC_PATH/.dvc/index.htm
   endif
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
