echo "<tr class=data>"
echo "<td class=col1> <a href=../$dir/> $dir </a></td>"
echo "<td class=col2><pre>"
svn list $DESIGN_URL/$dir/ --depth infinity 
echo "</pre></td>"
echo "<td class=col3><pre>"
echo "<object name=design_files type=text/html data=../$dir/.dvc/DESIGN_FILES></object>"
echo "</pre></td></tr>"
