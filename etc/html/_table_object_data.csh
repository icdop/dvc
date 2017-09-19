echo "<tr class=data>"
echo "<td class=col1>"
echo "<pre>"
echo "<a href=../$curr_name>"
echo "$curr_name"
echo "</a>"
echo "</pre>"
echo "</td>"

echo "<td class=col2>"
echo "<pre>"
#svn info $PROJT_URL/$curr_head/$curr_name
echo "</pre>"
echo "</td>"

echo "<td class=col3>"
echo "<pre>"
if {(test -d $curr_path)} then
   ls -1 $curr_path
else if {(test -f $curr_path)} then
   head -n 5 $curr_path
endif
echo "</pre>"
echo "</td></tr>"
