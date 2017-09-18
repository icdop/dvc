echo "<tr class=data><td></td><td></td><td></td><td></td>"
echo "<td class=col1 colspan=2> <a href=../$stage/.dvc/index.htm> $stage </a></td>"
echo "<td class=col2><pre>"
svn cat $DESIGN_URL/$stage/.dvc/README 
echo "</pre></td>"
echo "<td class=col3><pre>"
#echo "<object name=summary type=text/html data=../$stage/.dvc/DESIGN_FILES></object>"
svn cat $DESIGN_URL/$stage/.dvc/DESIGN_FILES
echo "</pre></td></tr>"
