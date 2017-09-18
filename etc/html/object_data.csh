echo "<tr class=data>"
echo "<td class=col1> <a href=../$fname> $fname </a></td>"
echo "<td class=col2><pre>"
svn info $DESIGN_URL/$fname
echo "</pre></td>"
echo "<td class=col3><pre>"
echo "</pre></td></tr>" >> $
