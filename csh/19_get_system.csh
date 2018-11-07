#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--mod <module>][--root_path <path>]"
   exit -1
endif

set dop_mode = dvc
set root_path = $0:h/..
setenv DVC_HOME  $root_path

if ($?DOP_HOME == 0) then
   setenv DOP_HOME `realpath $0:h/../..`
endif

if ($?DVC_HOME == 0) then
   setenv DVC_HOME $DOP_HOME/dvc
endif
if ($?DQR_HOME == 0) then
   setenv DQR_HOME $DOP_HOME/dqr
endif
if ($?DCM_HOME == 0) then
   setenv DQR_HOME $DOP_HOME/dcm
endif
if ($?DFA_HOME == 0) then
   setenv DQR_HOME $DOP_HOME/dfa
endif

if ($1 == "--mod") then
   shift argv
   switch($1)
   case "dop":
      set dop_mode=dop
      set root_path=$DOP_HOME
      shift argv
      breaksw
   case "dvc":
      set dop_mode=dvc
      set root_path=$DVC_HOME
      shift argv
      breaksw
   case "dqi":
      set dop_mode=dqi
      set root_path=$DQR_HOME
      shift argv
      breaksw
   case "dcm":
      set dop_mode=dcm
      set root_path=$DCM_HOME
      shift argv
      breaksw
   case "dfa":
      set dop_mode=dfa
      set root_path=$DFA_HOME
      shift argv
      breaksw
   endsw
endif

if {(test -f $root_path/etc/VERSION)} then
   setenv DVC_VERSION `cat $root_path/etc/VERSION`
else
   setenv DVC_VERSION ":undefined:"
endif

switch($1)
case "--root_path":
   echo $root_path
   shift argv
   breaksw
default:
   echo "INFO: DVC_VERSON = $DVC_VERSION"
endsw
