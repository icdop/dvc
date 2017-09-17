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
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if ($1 != "") then
   setenv DESIGN_VERSN $1
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

setenv DVC_PATH $DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
setenv DESIGN_URL $SVN_URL/$DESIGN_PROJT/$DVC_PATH
svn info $DESIGN_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Can not find path : $DVC_PATH"
   exit 1
endif

set name_list=`$CSH_DIR/44_list_version.csh $DESIGN_VERSN`
if ($status != 0) then
   echo "ERROR: Can access project folder: $DESIGN_VERSN"
   exit 1
endif
set flist = ""

set idxhtml="$CURR_PROJT/$DVC_PATH/.dvc/index.htm"
if {(test -e $idxhtml)} then
   set idx_exist=1
else
   set idxhtml=`mktemp`
endif

echo "<html>" > $idxhtml
echo "<head>" >> $idxhtml
echo "<title>Index Table - $DVC_PATH </title>" >> $idxhtml
echo '<link rel="stylesheet" type="text/css" href="css/index.css" > '>> $idxhtml 
eval $cmd_get_css >> $idxhtml 
echo "</head>" >> $idxhtml

echo "<body>" >> $idxhtml
echo "<table id=indextable>" >> $idxhtml
echo "<tr class=header><td colspan=3><h2>dvc://$DESIGN_PROJT/$DVC_PATH</h2></td></tr>" >> $idxhtml
echo "<tr class=title><td><b>VERSION</b></td><td><b>README</b></td><td><b>SUMMARY</b></td></tr>" >> $idxhtml
echo "<tr>" >> $idxhtml
echo "<td class=col1>$DESIGN_VERSN</td>" >> $idxhtml
echo "<td class=col2><pre>" >> $idxhtml
echo '<object name="readme" type="text/html" data="README"></object>'>> $idxhtml
echo "</pre></td>" >> $idxhtml
echo "<td class=col3> </td>" >> $idxhtml
echo "</tr>" >> $idxhtml

echo "<tr class=title><td><b>CONTAINER</b></td><td><b>README</b></td><td><b>STATUS</b></td></tr>" >> $idxhtml
foreach name ($name_list)
    set dir=$name:h
    svn info $DESIGN_URL/$name/.dvc/ >& /dev/null
    if ($status == 0) then
       echo "Container : $dir"
       echo "<tr class=data>" >> $idxhtml
       echo "<td class=col1> <a href=../$dir/> $dir </a></td>" >> $idxhtml
       echo "<td class=col2><pre>" >> $idxhtml
       svn list $DESIGN_URL/$dir/ --depth infinity  >> $idxhtml
       echo "</pre></td>" >> $idxhtml
       echo "<td class=col3><pre>" >> $idxhtml
       echo '<object name="design_files" type="text/html" data="../$dir/.dvc/DESIGN_FILES"></object>'>> $idxhtml
       tree $CURR_PROJT/$DVC_PATH >> $idxhtml
       echo "</pre></td></tr>" >> $idxhtml
    else
       set flist="$flist $name"
    endif
end
echo "file list = $flist"
echo "<tr class=title><td><b>FILE</b></td><td><b>INFO</b></td><td><b>INDICATOR</b></td></tr>" >> $idxhtml
foreach name ($flist)
    set fname=$name:t
    svn info $DESIGN_URL/$name >& /dev/null
    if ($status == 0) then
       echo "File : $name"
       echo "<tr class=data>" >> $idxhtml
       echo "<td class=col1> <a href=../$fname> $fname </a></td>" >> $idxhtml
       echo "<td class=col2><pre>" >> $idxhtml
       svn info $DESIGN_URL/$fname >> $idxhtml
       echo "</pre></td>" >> $idxhtml
       echo "<td class=col3><pre>" >> $idxhtml
       echo "</pre></td></tr>" >> $idxhtml
    endif 
end
echo "</table>" >> $idxhtml
echo "<p>Table created by $USER @ `date`</p>" >> $idxhtml
echo "</body>" >> $idxhtml
echo "</html>" >> $idxhtml

if ($?idx_exist == 1) then
   svn add --quiet --force $idxhtml
   svn commit --quiet  $idxhtml -m 'Update Directory Index' 
else
   svn info $DESIGN_URL/.dvc/index.htm >& /dev/null
   if ($status == 0) then
      svn delete --quiet --force $DESIGN_URL/.dvc/index.htm -m 'Delete Index'
   endif
   svn import --quiet --force $idxhtml  $DESIGN_URL/.dvc/index.htm -m 'Directory Index' 
   if ($status == 0) then
      if {(test -d $CURR_PROJT/$DVC_PATH/.dvc/)} then
         svn update --quiet $CURR_PROJT/$DVC_PATH/.dvc/
      endif
      rm -f $idxhtml
   else
      mkdir -p $CURR_PROJT/$DVC_PATH/.dvc/
      mv $idxhtml $CURR_PROJT/$DVC_PATH/.dvc/index.htm
   endif
endif

echo "TIME: @`date +%Y%m%d_%H%M%S` END   $prog"
echo "======================================================="
exit 0
