echo "<table id=report>"
echo "<tr class=header><td colspan=3><h2>dvc://$project/$report_path/</h2></td></tr>"

echo "<tr class=title>"
echo "<td>CURRENT</td>"
echo "<td>README</td>"
echo "<td>STATUS</td>"
echo "</tr>"

echo "<tr class=data>"
echo "<td class=col1>"
echo "<pre>"
echo "<a href=../../.dvc/index.htm>"
echo "$report_name"
echo "</a>"
echo "</pre>"
echo "</td>" 

echo "<td class=col2>" 
echo "<pre>"
echo "<object name=readme type=text/html data=README></object>"
echo "</pre>"
echo "</td>"
 
echo "<td class=col3>"
echo "<pre>"
echo "<object name=readme type=text/html data=DESIGN_FILES></object>"
echo "</pre>"
echo "</td>" 
echo "</tr>" 

echo "</table>"

