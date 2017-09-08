#!/bin/csh -f
cd ../..
setenv DOP_HOME `pwd`
cd -
echo "DOP_HOME = $DOP_HOME"
set path = ($DOP_HOME/dvc/bin $path)

setenv SVN_ROOT $PWD/PROJ_SVN
setenv SVN_URL  file://$SVN_ROOT


