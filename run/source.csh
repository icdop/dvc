#!/bin/csh -f
cd ..
setenv DVC_HOME `pwd`
cd -
echo "DVC_HOME = $DVC_HOME"
set path = ($DVC_HOME/bin $path)

setenv SVN_ROOT $HOME/proj_svn
#setenv SVN_URL  file://$SVN_ROOT

