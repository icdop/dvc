#!/bin/csh -f
set prog=$0:t
if ($prog == "CSHRC.dvc") then
   setenv DVC_HOME `realpath $0:h`
else
   setenv DVC_HOME `pwd`
endif
echo "DVC_HOME = $DVC_HOME"
set path = ($DVC_HOME/bin $path)

setenv SVN_ROOT $HOME/svn_root
