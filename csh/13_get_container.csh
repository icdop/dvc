#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [-v]"
   exit -1
endif
if (($1 == "-v") || ($1 == "--verbose")) then
   set pvar = 1
else
   set pvar = 0
endif
if (($1 != "") && ($1 != "-")) then
   setenv CONTAINER $1
#   echo "PARA: CONTAINER = $CONTAINER"
   if {(test -d $CONTAINER)} then
      # parameter is a directory
      setenv DVC_CONTAINER $CONTAINER
   else if {(test -d .design/-/-/$CONTAINER)} then
     setenv DVC_CONTAINER .design/-/-/$CONTAINER
   else if {(test -d .project/-/-/-/-/$CONTAINER)} then
     setenv DVC_CONTAINER .project/-/-/-/-/$CONTAINER
   endif
else if {(test -d .container)} then
  setenv DVC_CONTAINER .container
else
  setenv DVC_CONTAINER .
endif

if {(test -d $DVC_CONTAINER/.svn)} then
   if {(test -e $DVC_CONTAINER/.dvc/env/SVN_CONTAINER)} then
      setenv SVN_CONTAINER `cat $DVC_CONTAINER/.dvc/env/SVN_CONTAINER`
   else
      echo "ERROR: Not a valide container : $DVC_CONTAINER"
      exit -1
   endif
else
   echo "ERROR: Not a valide SVN folder : $DVC_CONTAINER"
   exit -1
endif
