#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DESIGN_URL>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh
source $CSH_DIR/14_get_version.csh

if (($1 != "") && ($1 != ":")) then
   setenv DESIGN_URL $SVN_URL/$1
else if ($?DESIGN_URL == 0) then
   setenv DESIGN_URL .container
endif

svn info $DESIGN_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Path : $DESIGN_URL"
   exit 1
endif

if ($verbose_mode == 1) then
   echo "------------------------------------------------------------"
   echo "URL: $DESIGN_URL"
   echo "------------------------------------------------------------"
   svn info $DESIGN_URL
   echo "------------------------------------------------------------"
   svn list $DESIGN_URL -v
else if ($?recursive_mode == 1) then
#   svn list $DESIGN_URL --recursive --depth immediates
   svn list $DESIGN_URL --recursive
else if ($?xml_mode == 1) then
   svn list $DESIGN_URL --xml
else
   svn list $DESIGN_URL
endif
