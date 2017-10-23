echo "<tr class=data>"
echo "<td class=col1>"
echo "<a href=$item_name/index.htm>"
echo "$item_name"
echo "</a>"
echo "</td>"

echo "<td class=col2>"
cat "$item_data/.dvc/README"
echo "</td>"

foreach dqi ($container_dqi)
  echo "<td width=10>"
  dvc_get_dqi --root $item_data $dqi
  echo "</td>"
end

echo "</tr>"
