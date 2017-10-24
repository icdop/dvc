#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [-v]"
   exit -1
endif
if (($1 == "-v") || ($1 == "--verbose")) then
   set verbose_mode = 1
   shift argv
endif

if ($1 == "--info") then
   set info_mode = 1
   shift argv
endif

if ($1 == "--force") then
   set force_mode=1
   shift argv
endif

switch($1)
case "--recursive":
   set recursive_mode = 1
   set depth_mode = infinity
   shift argv
   breaksw
case "--infinity":
   set recursive_mode = 1
   set depth_mode = infinity
   shift argv
   breaksw
cace "--empty":
   set depth_mode = empty
   shift argv
   breaksw
case "--files":
   set depth_mode = files
   shift argv
   breaksw
case "--immediates":
   set depth_mode = immediates
   shift argv
   breaksw
case "--depth":
   shift argv
   set depth_mode = $1
   shift argv
   breaksw
endsw

if ($1 == "--root") then
   shift argv
   setenv SVN_ROOT $1
   shift argv
endif

if {(test -e .dop/env/SVN_ROOT)} then
   setenv SVN_ROOT  `cat .dop/env/SVN_ROOT`
else if ($?SVN_ROOT == 0) then
   echo "ERROR: env variable (SVN_ROOT) is not set yet."
   exit 1
endif

if {(test -e $SVN_ROOT/.dop/svnserve.pid)} then
  setenv SVN_PID      `cat $SVN_ROOT/.dop/svnserve.pid`
else
  unsetenv SVN_PID
endif

if ($?SVN_MODE == 0) then
   if {(test -f $SVN_ROOT/.dop/env/SVN_MODE)} then
     setenv SVN_MODE      `cat $SVN_ROOT/.dop/env/SVN_MODE`
   else
     setenv SVN_MODE      file
   endif
endif

if ($?SVN_HOST == 0) then
   if {(test -f $SVN_ROOT/.dop/env/SVN_HOST)} then
     setenv SVN_HOST      `cat $SVN_ROOT/.dop/env/SVN_HOST`
   else
     setenv SVN_HOST      `hostname`
   endif
endif

if ($?SVN_PORT == 0) then
   if {(test -f $SVN_ROOT/.dop/env/SVN_PORT)} then
     setenv SVN_PORT      `cat $SVN_ROOT/.dop/env/SVN_PORT`
   else
     setenv SVN_PORT      3690
   endif
endif

if ($?SVN_URL == 0) then
   if ($SVN_MODE == "svn") then
      setenv SVN_URL "svn://$SVN_HOST"":$SVN_PORT/"
   else
      setenv SVN_URL "file://`realpath $SVN_ROOT`"
   endif
endif

if ($?info_mode) then
  echo "INFO: SVN_ROOT = $SVN_ROOT"
  echo "INFO: SVN_MODE = $SVN_MODE"
  echo "INFO: SVN_HOST = $SVN_HOST"
  echo "INFO: SVN_PORT = $SVN_PORT"
  echo "INFO: SVN_URL  = $SVN_URL"
endif


