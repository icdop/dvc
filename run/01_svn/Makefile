##################################
SVN_ROOT     := $(HOME)/proj_svn
SVN_HOST     := `hostname`
SVN_PORT     := 3691
SVN_PID      := svnserve.pid
SVN_URL      := svn://$(SVN_HOST):$(SVN_PORT)

##################################
DESIGN_PROJT := testcase
DESIGN_PHASE := P1-trial
DESIGN_BLOCK := chip
DESIGN_STAGE := 400-APR
DESIGN_VERSN := 2017_0615-xxx
DESIGN_CONTR := place_opt

# The following object will be checkin to container
OBJECT_FILES := design.def  run_apr.log 
OBJECT_DIRS  := report/ cache/
OBJECT_LINKS := design.spef

# The following files in .container will be added to repo
ADD_OBJECTS  := design.v

# The following files in .container will be removed from repo
DEL_OBJECTS  := cache/

####################################################################

include ../../etc/make/checkin.make

####################################################################

server: $(SVN_PID)
	
$(SVN_PID): 
	mkdir -p $(SVN_ROOT)
	svnserve -d -r $(SVN_ROOT) --listen-host=$(SVN_HOST) --listen-port=$(SVN_PORT) --pid-file=$(SVN_PID)
	

