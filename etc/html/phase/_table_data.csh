echo "<tr class=data>"
echo "<td class=col1>"
echo "<a href=$item_name/index.htm>"
echo "$item_name"
echo "</a>"
echo "</td>"
foreach dqi ($block_dqi)
  echo "<td class=col2 width=10>"
  dvc_get_dqi --root $item_data $dqi
  echo "</td>"
end
echo "<td class=col3>"
echo `cat $item_data/:/:/.dvc/DESIGN_PATH`
echo "</td>"
echo "</tr>"
