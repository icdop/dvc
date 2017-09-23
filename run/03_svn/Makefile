PATH         :=	../../bin:$(PATH)
##################################
SVN_ROOT     := $(HOME)/proj_svn
SVN_MODE     := svn
SVN_HOST     := `hostname`
#SVN_PORT     := 3690
#SVN_URL      := svn://$(SVN_HOST):$(SVN_PORT)

####################################################################
# The follwing parameter are checkout pointer configuration.
# Do not change it unless you need to
PROJT_ROOT   := :
CURR_PHASE   := :phase
CURR_BLOCK   := :block
CURR_STAGE   := :stage
CURR_VERSN   := :version
CURR_CONTR   := :container

##################################
DESIGN_PROJT := testcase
DESIGN_PHASE := P1-trial
DESIGN_BLOCK := chip
DESIGN_STAGE := 420-place
DESIGN_VERSN := 2017_0615-xxx
DESIGN_CONTR := place_opt

# The following object will be checkin to container
OBJECT_FILES := design.def  run_apr.log 
OBJECT_DIRS  := report/ cache/
OBJECT_LINKS := design.spef

# The following files in :container will be added to repo
# Remember that you have to copy them to :container/ first
ADD_OBJECTS  := design.v

# The following files in .container will be removed from repo
DEL_OBJECTS  := cache/


####################################################################
# The following makefile template is required
####################################################################

include ../../etc/make/checkin.make

####################################################################
