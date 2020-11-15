#!/bin/csh -f 
set prog=$0:t
if ("$prog" == "setup.cshrc") then
   setenv DVC_HOME `realpath $0:h`
   echo "DVC_HOME = $DVC_HOME"
   echo "Create CSHRC.dvc ..."
   echo '#\!/bin/csh -f v' > CSHRC.dvc
   echo "setenv DVC_HOME $DVC_HOME" >> CSHRC.dvc
   echo 'setenv PATH "$DVC_HOME/bin/:$PATH"' >> CSHRC.dvc
   echo 'setenv SVN_ROOT svnroot' >> CSHRC.dvc
   echo 'setenv SVN_MODE svn' >> CSHRC.dvc
   echo 'setenv SVN_HOST localhost' >> CSHRC.dvc
   echo 'setenv SVN_PORT 3690' >> CSHRC.dvc
   echo "# `date` " >> CSHRC.dvc
   echo '' >> CSHRC.dvc
   chmod +x CSHRC.dvc
   source CSHRC.dvc
   exit
endif
#echo $1
if ($?DVC_HOME != 0) then
   echo "DVC_HOME = $DVC_HOME"
else if ("$prog" == "csh") then
   setenv DVC_HOME "/tools/icdop/dvc"
   echo "DVC_HOME = $DVC_HOME"
   set path = ($DVC_HOME/bin $path)
else
   setenv DVC_HOME "/tools/icdop/dvc"
   echo "DVC_HOME = $DVC_HOME"
   set path = ($DVC_HOME/bin $path)
endif

if ($?SVN_MODE != 0) then
   echo "SVN_MODE = $SVN_MODE"
   echo "SVN_HOST = $SVN_HOST"
   echo "SVN_PORT = $SVN_PORT"
else
   setenv SVN_MODE svn
   setenv SVN_HOST localhost
   setenv SVN_PORT 3690
endif
