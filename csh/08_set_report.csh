#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [-d <dir>] [-c <container>]"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/
endif
setenv CSH_DIR $DVC_HOME/csh 
setenv ETC_DIR $DVC_HOME/etc
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

set cmd_get_css = ""
if ($1 == "-css") then
   shift argv
   if ($1 != "") then
     set css_file=$1
     shift argv
     if (test -e $css_file)) then
        set cmd_get_css = "cat $1"
     endif
   endif
endif

if ($1 != "") then
  if (($1 != ":") && ($1 != ".")) then
    setenv DESIGN_PROJT $1
  endif
  shift argv
endif


setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
svn info $PROJT_URL >& /dev/null
if ($status != 0) then
   echo "ERROR: Can not find Project Design Respository : $DESIGN_PROJT"
   exit 1
endif
