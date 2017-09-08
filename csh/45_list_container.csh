#!/bin/csh -f
# set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_CONTR>"
   exit -1
endif
if ($1 == "--verbose") then
   set verbose_mode = 1
   shift argv
else if ($?verbose_mode == 0) then 
   set verbose_mode = 0
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh
source $CSH_DIR/15_get_container.csh

if {(test -d $DVC_CONTAINER)} then
   setenv DESIGN_URL $SVN_URL/$DESIGN_PROJT/$SVN_CONTAINER
   source $CSH_DIR/49_list_design.csh
else
   echo "ERROR: Can not find Container : $DVC_CONTAINER"
endif
 