#!/bin/csh 
set prog=$0:t
if ($prog == "setup.cshrc") then
   setenv DVC_HOME `realpath $0:h`
else
   setenv DVC_HOME `pwd`
endif
set path = ($DVC_HOME/bin $path)
echo "# `date` " > CSHRC.dvc
echo "setenv DVC_HOME $DVC_HOME" >> CSHRC.dvc
echo 'setenv PATH $DVC_HOME/bin/:$PATH' >> CSHRC.dvc
echo "" >> CSHRC.dvc

