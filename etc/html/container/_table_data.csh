echo "<tr class=data>"
echo "<td class=col1>"
echo "<a href=../$item_name/.htm/index.htm>"
echo "$item_name"
echo "</a>"
echo "</td>"

echo "<td class=col2>"
echo "<pre>"
#svn info $SVN_URL/$project/$item_path
echo "</pre>"
echo "</td>"

echo "<td class=col3>"
echo "<pre>"
if {(test -d $item_data)} then
   tree $item_data
else if {(test -f $item_data)} then
   head -n 5 $item_data
endif
echo "</pre>"
echo "</td></tr>"
