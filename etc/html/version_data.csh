echo "<tr class=data><td></td><td></td><td></td><td></td>"
echo "<td class=col1> <a href=../$versn/.dvc/index.htm> $versn </a></td>"
echo "<td class=col2><pre>"
svn cat $DESIGN_URL/$versn/.dvc/README 
echo "</pre></td>"
echo "<td class=col3><pre>"
#echo '<object versn="summary" type="text/html" data="../$versn/.dvc/DESIGN_FILES"></object>'>> $idxhtml
svn cat $DESIGN_URL/$versn/.dvc/DESIGN_FILES
echo "</pre></td></tr>"
