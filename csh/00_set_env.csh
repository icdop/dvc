#!/bin/csh -f
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog <variable> <value>"
   exit -1
endif
switch ($1)
 case "-h":
 case "--help":
   exit -1
 case "":
  if {(test -d .dvc/env)} then
     ls .dvc/env  
  endif
  exit -1
 case "-home":
  if {(test -d $HOME/.dvc/env)} then
     ls $HOME/.dvc/env  
  endif
  exit -1

 default:   
   set varname = $1

   if {(test -e .dvc/env/$varname)} then
      echo "$varname =  `cat .dvc/env/$varname`"
   else if {(test -e $HOME/.dvc/env/$varname)} then
      echo "$varname =  `cat $HOME/.dvc`"
   else 
      echo "Variable '$varname' Undefined!"
   endif
 breaksw
endsw

