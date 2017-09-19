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
foreach object (`ls -1 $curr_path`)
  if {(test -d $object)} then
     echo "<a href=../$curr_name/$object>$object </a>"
  else
     echo "<a href=../$curr_name/$object>$object </a>"
  endif
end
echo "</pre>"
echo "</td></tr>"
