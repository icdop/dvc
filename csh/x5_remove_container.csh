#!/bin/csh -f
#set verbose=1
if (($1 == "") || ($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $0:t <DESIGN_VERSN> <DESIGN_STAGE>"
   exit -1
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $0:h/..
endif
source $DVC_HOME/csh/12_get_server.csh
source $DVC_HOME/csh/13_get_project.csh
source $DVC_HOME/csh/14_get_version.csh
source $DVC_HOME/csh/15_get_container.csh

if {((test -d $CONTAINER_DIR)&&(test -d .project/$DVC_CONTAINER))} then
   echo "INFO: Remove Project Design Container '$DVC_CONTAINER'."
   rm -fr .project/$DVC_CONTAINER
   svn remove $SVN_URL/$DESIGN_PROJT/$DVC_CONTAINER -m "Remove Design Container"
   if {(test -d .container)} then
      mv .container .container.`date +%Y%m%d_%H%M%S`
   else
      rm -fr .container
   endif
else
   echo "ERROR: Can not remove Design Container '$CONTAINER_DIR'!"
endif
