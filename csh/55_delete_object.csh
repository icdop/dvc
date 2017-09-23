#!/bin/csh -f
set prog = $0:t
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_OBJECT> ..."
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh
source $CSH_DIR/16_get_object.csh

if ($status < 0) then 
   exit $status 
endif

while ($1 != "") 

   set filename =  $1
   (cd $CONTAINER_DIR; svn del $filename --force)

   shift argv
end

