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
dvc_get_dqi --root $curr_path --script --all
echo "</pre>"
echo "</td>"

echo "<td class=col3>"
echo "<pre>"
ls -1 $curr_path
echo "</pre>"
echo "</td></tr>"
