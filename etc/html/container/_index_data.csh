
echo "<table id=report>"
echo "<tr class=header><td colspan=3><h2>dvc://$project/$dvc_path/</h2></td></tr>"

echo "<tr class=title>"
echo "<td>CURRENT</td>"
echo "<td>README</td>"
echo "<td>STATUS</td>"
echo "</tr>"

echo "<tr class=data>"
echo "<td class=col1>"
echo "<pre>"
echo "<a href=../index.htm>"
echo "$dvc_name"
echo "</a>"
echo "</pre>"
echo "</td>" 

echo "<td class=col2>" 
echo "<pre>"
echo "<img width=200 height=200 src=$dvc_name.jpg alt=Chip></img>"
echo "</pre>"
echo "</td>"
 
echo "<td class=col3>"
echo "<pre>"
dvc_get_dqi --root $dvc_data --script --all
echo "</pre>"
echo "</td>" 
echo "</tr>" 

echo "</table>"

