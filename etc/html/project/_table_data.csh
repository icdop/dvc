echo "<tr class=data>"
echo "<td class=col1>"
echo "<a href=$item_name/index.htm>"
echo "$item_name"
echo "</a>"
echo "</td>"

echo "<td class=col2>" 
echo "<object name=readme type=text/html data=$item_name/.dvc/README width=300></object>"
echo "</td>" 

echo "<td class=col3>"
dvc_get_dqi --root $item_data --html --all
echo "</td>"

echo "</tr>"
