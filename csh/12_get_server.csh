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

if ($1 == "--recursive") then
   set recursive_mode = 1
   set depth_mode = infinity
   shift argv
endif

switch($1)
case "--infinity":
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
case "--depth")) then
   shift argv
   set depth_mode = $1
   shift argv
   breaksw
default:
   set depth_mode = immediates
endsw

if ($1 == "--xml") then
   set xml_mode = 1
   shift argv
endif


if {(test -e .dop/server/SVN_ROOT)} then
  setenv SVN_ROOT  `cat .dop/server/SVN_ROOT`
else if {(test -e $HOME/.dop/server/SVN_ROOT)} then
  setenv SVN_ROOT  `cat $HOME/.dop/server/SVN_ROOT`
else if ($?SVN_ROOT == 0) then
  setenv SVN_ROOT  $HOME/SVN_ROOT
endif

if {(test -e .dop/server/SVN_MODE)} then
  setenv SVN_MODE      `cat .dop/server/SVN_MODE`
else if {(test -e $HOME/.dop/server/SVN_MODE)} then
  setenv SVN_MODE      `cat $HOME/.dop/server/SVN_MODE`
else if ($?SVN_MODE == 0) then
  setenv SVN_MODE      file
endif

if {(test -e .dop/server/SVN_HOST)} then
  setenv SVN_HOST      `cat .dop/server/SVN_HOST`
else if {(test -e $HOME/.dop/server/SVN_HOST)} then
  setenv SVN_HOST      `cat $HOME/.dop/server/SVN_HOST`
else if ($?SVN_HOST == 0) then
  setenv SVN_HOST      `hostname`
endif

if {(test -e .dop/server/SVN_PORT)} then
  setenv SVN_PORT      `cat .dop/server/SVN_PORT`
else if {(test -e $HOME/.dop/server/SVN_PORT)} then
  setenv SVN_PORT      `cat $HOME/.dop/server/SVN_PORT`
else if ($?SVN_PORT == 0) then
  setenv SVN_PORT      3690
endif

if {(test -e .dop/server/SVN_URL)} then
  setenv SVN_URL      `cat .dop/server/SVN_URL`
else if {(test -e $HOME/.dop/server/SVN_URL)} then
  setenv SVN_URL      `cat $HOME/.dop/server/SVN_URL`
else if ($?SVN_URL == 0) then
  if ($SVN_MODE == "svn") then
     setenv SVN_URL "svn://$SVN_HOST"":$SVN_PORT/"
  else
     setenv SVN_URL "file://$SVN_ROOT"
  endif
endif

