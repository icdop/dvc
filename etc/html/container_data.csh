echo "<tr class=data>"
echo "<td class=col1>"
echo "<pre>"
echo "<a href=../$curr_name/.dvc/index.htm>"
echo "$curr_name"
echo "</a>"
echo "</pre>"
echo "</td>"

echo "<td class=col2>"
echo "<pre>"
cat $curr_path/.dvc/README
echo "</pre>"
echo "</td>"

echo "<td class=col3>"
echo "<pre>"
ls -al $curr_path
echo "</pre>"
echo "</td></tr>"
