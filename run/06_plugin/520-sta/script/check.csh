#!/bin/csh -f

echo "Start checking if all required files are ready.."
set required_file = $1

set file_list=`awk '{ print $1 }' $required_file`

set error=0
foreach file ($file_list)
  if {(test -f .version/$file)} then
     echo "INFO: '$file' exist."
  else
     echo "INFO: '$file' is required, but does not exist in :version/"
     @ error ++
  endif
end

exit $error
