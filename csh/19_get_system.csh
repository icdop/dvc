#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--dop|--dvc|--dqr|--dcm|--dfa|--dvs] [--dop_version|--dop_path]"
   exit -1
endif

set dop_mode = dvc
set dop_path = $0:h/..
setenv DVC_HOME  $dop_path

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

if ($1 == "--dop_mode") then
   shift argv
   switch($1)
   case "dop":
      set dop_mode=dop
      set dop_path=$DOP_HOME
      shift argv
      breaksw
   case "dvc":
      set dop_mode=dvc
      set dop_path=$DVC_HOME
      shift argv
      breaksw
   case "dqr":
      set dop_mode=dqr
      set dop_path=$DQR_HOME
      shift argv
      breaksw
   case "dcm":
      set dop_mode=dcm
      set dop_path=$DCM_HOME
      shift argv
      breaksw
   case "dfa":
      set dop_mode=dfa
      set dop_path=$DFA_HOME
      shift argv
      breaksw
   endsw
endif

if {(test -f $dop_path/etc/DOP_VERSION)} then
   setenv DOP_VERSION `cat $dop_path/etc/DOP_VERSION`
else
   setenv DOP_VERSION ":undefined:"
endif

switch($1)
case "--dop_version":
   echo $DOP_VERSION
   shift argv
   breaksw
case "--dop_path":
   echo $dop_path
   shift argv
   breaksw
default:
   echo "INFO: DOP_VERSON = $DOP_VERSION"
endsw
