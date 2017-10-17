echo "<tr class=data>"
echo "<td class=col1>"
echo "<a href=../$item_name/.htm/index.htm>"
echo "$item_name"
echo "</a>"
echo "</td>"

echo "<td class=col2>"
echo "<pre>" 
dvc_get_dqi --root $item_data --script --all
echo "</pre>" 
echo "</td>"

echo "<td class=col3>"
foreach object (`ls -1 $item_data`)
  if {(test -d $object)} then
     echo "<a href=$item_name/$object>$object </a><br>"
  else
     echo "<a href=$item_name/$object>$object </a><br>"
  endif
end
echo "</td></tr>"
