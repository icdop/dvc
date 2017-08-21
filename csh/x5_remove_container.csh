#!/bin/csh -f
#set verbose=1
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif

if ($?DOP_HOME == 0) then
   setenv DOP_HOME $0:h/../..
endif
source $DOP_HOME/dvc/csh/11_get_svn.csh
source $DOP_HOME/dvc/csh/14_get_version.csh
source $DOP_HOME/dvc/csh/15_get_container.csh

if {((test -d $DVC_CONTAINER)&&(test -d .project/$SVN_CONTAINER))} then
   echo "INFO: Remove Project Design Container - $SVN_CONTAINER ..."
   rm -fr .project/$SVN_CONTAINER
   svn remove $SVN_URL/$DESIGN_PROJT/$SVN_CONTAINER -m "Remove Design Container $SVN_CONTAINER"
   if {(test -d .container)} then
   else
      rm -f .container
   endif
else
   echo "ERROR: Can not find Design Container - $DVC_CONTAINER"
endif
