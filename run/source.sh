#!/bin/sh 
cd ../..
DOP_HOME=`pwd`
export DOP_HOME
cd -
echo "DOP_HOME = $DOP_HOME"
PATH=$DOP_HOME/dvc/bin:$PATH; export PATH
SVN_ROOT=$PWD/PROJ_SVN; export SVN_ROOT
SVN_URL=file://$SVN_ROOT; export SVN_URL
 
