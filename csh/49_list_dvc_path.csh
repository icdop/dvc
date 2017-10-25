#!/bin/csh -f
#set verbose=1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <DVC_PATH>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
setenv CSH_DIR $DVC_HOME/csh
source $CSH_DIR/12_get_server.csh
source $CSH_DIR/13_get_project.csh

setenv PROJT_URL $SVN_URL/$DESIGN_PROJT
 
# If DESIGN_URL is defined and no args is specified
# it may be called form other dvc_list_* command
# this is used to preserved all option modes of parent commands 

if ($1 != "") then
   set dir $1
   if {(test -e $dir/.dvc/env/DESIGN_PATH)} then
      if {(test -e $dir/.dvc/env/DESIGN_CONTR)} then
         setenv DESIGN_URL $PROJT_URL/`cat $dir/.dvc/env/DESIGN_PATH`/`cat $dir/.dvc/env/DESIGN_CONTR`
      else
         setenv DESIGN_URL $PROJT_URL/`cat $dir/.dvc/env/DESIGN_PATH`
      endif
   else
      setenv DESIGN_URL $PROJT_URL/$dir
   endif
else if ($?DESIGN_URL == 0) then
   source $CSH_DIR/14_get_design.csh
   setenv DESIGN_URL $PROJT_URL/$DESIGN_PHASE/$DESIGN_BLOCK/$DESIGN_STAGE/$DESIGN_VERSN
endif

svn info $DESIGN_URL >& /dev/null
if ($status == 1) then
   echo "ERROR: Cannot find Project Design Path : $DESIGN_URL"
   exit 1
endif

if ($?verbose_mode) then
   echo "------------------------------------------------------------"
   echo "URL: $DESIGN_URL"
   echo "------------------------------------------------------------"
   if ($?info_mode) then
      svn info $DESIGN_URL
      echo "------------------------------------------------------------"
   endif
   svn list $DESIGN_URL -v
   echo "------------------------------------------------------------"
else if ($?recursive_mode) then
#   svn list $DESIGN_URL --recursive --depth immediates
   svn list $DESIGN_URL --recursive | grep -v -e \: -e \.dvc\/ -e \.dqi\/ -e \.htm\/
else if ($?xml_mode) then
   svn list $DESIGN_URL --xml
else if ($?depth_mode) then
   svn list $DESIGN_URL --depth $depth_mode | grep -v -e \: -e \.dvc\/ -e \.dqi\/ -e \.htm\/
else
   svn list $DESIGN_URL | grep -v -e \: -e \.dvc\/ -e \.dqi\/ -e \.htm\/ | grep "/" | sed s%\/%%
endif

exit 0
