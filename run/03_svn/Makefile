PATH         :=	../../bin:$(PATH)
##################################
SVN_ROOT     := svn_root
SVN_MODE     := svn
SVN_HOST     := $(shell hostname)
SVN_PORT     := 3693

####################################################################
# The follwing parameter are checkout pointer configuration.
# Do not change it unless you need to
PTR_PHASE   := :phase
PTR_BLOCK   := :block
PTR_STAGE   := :stage
PTR_VERSN   := :version
PTR_CONTR   := :container

##################################
PROJT_PATH   := _
DESIGN_PROJT := 03-svn
#---------------------------------
DESIGN_PHASE := P1-trial
DESIGN_BLOCK := chip
DESIGN_STAGE := 420-place
DESIGN_VERSN := 2017_0615-xxx
#---------------------------------
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
