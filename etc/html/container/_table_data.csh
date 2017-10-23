echo "<tr class=data>"
echo "<td class=col1>"
echo "<a href=$item_name>"
echo "$item_name"
echo "</a>"
echo "</td>"

echo "<td class=col2>"
echo "<pre>"
file -b -i $item_data
echo "</pre>"
echo "</td>"

echo "<td class=col3>"
echo "<pre>"
svn info $SVN_URL/$project/$item_path | grep "Changed"
echo "</pre>"
echo "</td></tr>"
