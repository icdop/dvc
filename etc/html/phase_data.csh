echo "<tr class=data>"
echo "<td class=col1><a href=../$phase/.dvc/index.htm>$phase</a></td>"

echo "<td class=col2><pre>"
cat $CURR_PROJT/$phase/.dvc/README
echo "</pre></td>"

echo "<td class=col3><pre>"
ls -al $CURR_PROJT/$phase
echo "</pre></td></tr>"
