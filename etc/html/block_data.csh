echo "<tr class=data> <td></td><td></td><td></td>"
echo "<td class=col1 colspan=3> <a href=../$block/.dvc/index.htm> $block </a></td>"
echo "<td class=col2><pre>"
svn cat $DESIGN_URL/$block/.dvc/README 
echo "</pre></td>"
echo "<td class=col3><pre>"
echo "<object name=summary type=text/html data=../$block/.dvc/DESIGN_FILES></object>"
echo "</pre></td></tr>"
