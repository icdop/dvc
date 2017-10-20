#!/bin/csh -f
setenv DVC_HOME `pwd`
echo "DVC_HOME = $DVC_HOME"
set path = ($DVC_HOME/bin $path)

setenv SVN_ROOT $DVC_HOME/run/svn_root
