#!/bin/csh -f

echo "Start checking if all required files are ready.."
set input_design_file = $1

set file_list=`awk '{ print $2 }' $input_design_file`

set error=0
foreach file ($file_list)
  if {(test -f .data/$file)} then
#     echo "$file exist"
  else
     echo "$file does not exist in :container"
     @ error ++
  endif
end

exit $error
