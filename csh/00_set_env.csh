#!/bin/csh -f
switch ($1)
 case "":
 case "-h":
 case "--help":
   echo "Usage: $0:t <name> <value>"
  (cd .dvc/env/; ls)
  (cd $HOME/.dvc/env; ls)  
   exit -1

 default:   
   set varname = $1

   if {(test -e .dvc/env/$varname)} then
      echo "$varname =  `cat .dvc/env/$varname`"
   else if {(test -e $HOME/.dvc/env/$varname)} then
      echo "$varname =  `cat $HOME/.dvc
   else 
      echo "Variable '$varname' Undefined!"
   endif
 breaksw
endsw

