#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <CONTAINER>"
   exit -1
endif
if (($1 == "-v") || ($1 == "--verbose")) then
   set pvar = 1
   shift argv
else
   set pvar = 0
endif

if (($1 != "") && ($1 != ":")) then
   setenv CONTAINER $1
   if {(test -d $CONTAINER)} then
      # parameter is a directory
      setenv DVC_CONTAINER $CONTAINER
   else if {(test -d .dvc_version/$CONTAINER)} then
      setenv DVC_CONTAINER .dvc_version/$CONTAINER
   else if {(test -d .dvc_block/:/:/$CONTAINER)} then
      setenv DVC_CONTAINER .dvc_block/:/:/$CONTAINER
   else if {(test -d .project/:/:/:/:/:/$CONTAINER)} then
      setenv DVC_CONTAINER .project/:/:/:/:/:/$CONTAINER
   else
      setenv DVC_CONTAINER .dvc_version/$CONTAINER
   endif
else if {(test -h .dvc_container)} then
  setenv DVC_CONTAINER .dvc_container
else
  setenv DVC_CONTAINER .
endif

if ($pvar == 1) then
   echo "PARA: DVC_CONTAINER = $DVC_CONTAINER"
endif
if {(test -e $DVC_CONTAINER/.dvc/env/SVN_CONTAINER)} then
   setenv SVN_CONTAINER `cat $DVC_CONTAINER/.dvc/env/SVN_CONTAINER`
else
   setenv SVN_CONTAINER ":/:/:/:/:/$CONTAINER"
   echo "ERROR: Not a valid container : $DVC_CONTAINER"
   exit -1
endif
if {(test -d $DVC_CONTAINER/.svn)} then
else
   echo "ERROR: Not a valid SVN folder : $DVC_CONTAINER"
endif
