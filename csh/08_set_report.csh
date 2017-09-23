#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--html <dir>]"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/
endif
setenv CSH_DIR $DVC_HOME/csh 
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_design.csh

if (($1 == "--html")||($1 == "-html_templ")) then
   shift argv
   if ($1 != "") then
     set html_templ=$1
     shift argv
   endif
endif

if ($1 != "") then
  if (($1 != ":") && ($1 != ".")) then
    set report_index $1
  endif
  shift argv
endif


