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

if {(test -e .dop/env/HTML_TEMPL)} then
  setenv HTML_TEMPL `cat .dop/env/HTML_TEMPL`
else if {(test -e $HOME/.dop/env/HTML_TEMPL)} then
  setenv HTML_TEMPL `cat $HOME/.dop/env/HTML_TEMPL`
else if ($?HTML_TEMPL == 0) then
  setenv HTML_TEMPL $0:h/../etc/html
endif

if (($1 == "--html")||($1 == "--html_templ")) then
   shift argv
   if ($1 != "") then
     set html_templ = $1
     shift argv
   endif
else
   set html_templ = $HTML_TEMPL
endif
