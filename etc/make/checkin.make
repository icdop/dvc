########################################################################
#
# Design Version Control Checkin Example
#
########################################################################
ifndef SVN_ROOT
SVN_ROOT     := $(HOME)/proj_svn
endif

ifndef SVN_HOST
SVN_HOST     := `hostname`
endif

ifndef SVN_PORT
SVN_PORT     := 3691
endif

ifndef SVN_URL
SVN_URL      := svn://$(SVN_HOST):$(SVN_PORT)
endif

help:
	@echo "=============================================================="
	@echo "PWD      = $(PWD)"
	@echo "SVN_ROOT = $(SVN_ROOT)"
	@echo "SVN_URL  = $(SVN_URL)"
	@echo "=============================================================="
	@echo "Usage:"
	@echo "        make run       run the following steps"
	@echo ""
	@echo "        make init      (reset_resository)"
	@echo "        make project   (create_project)"
	@echo "        make version   (create_version; checkout_version)"
	@echo "        make container (create_container; checkout_container)"
	@echo "        make object    (checkin_object)"
	@echo "        make commit    (commit_container)"
	@echo ""
	@echo "Usage:  make list      (list_version; list_container)"
	@echo "Usage:  make clean     (clean_data)"
	@echo ""


run:
	make init
	make project
	make version
	make container
	make object
	make commit


init: init_repository
init_repository:
	@echo "#---------------------------------------------------"
	@echo "# 0. Assign SVN ROOT Path"
	@echo "#---------------------------------------------------"
	@echo "SVN_ROOT = $(SVN_ROOT)"
	dvc_set_server $(SVN_ROOT)  $(SVN_URL)
	make init_server

project: init
	@echo "#---------------------------------------------------"
	@echo "# 1. Initiatize Project Repository"
	@echo "#---------------------------------------------------"
	dvc_create_project	$(DESIGN_PROJT)

version: create_version checkout_version
create_version:
	@echo "#---------------------------------------------------"
	@echo "# 2. Create version directory in SVN server"
	@echo "#---------------------------------------------------"
	dvc_create_phase	$(DESIGN_PHASE)
	dvc_create_block	$(DESIGN_BLOCK)
	dvc_create_stage	$(DESIGN_STAGE)
	dvc_create_version	$(DESIGN_VERSN)

checkout: checkout_version
checkout_version:
	@echo "#---------------------------------------------------"
	@echo "# 3 Checkout version"
	@echo "#---------------------------------------------------"
	dvc_checkout_version	$(DESIGN_VERSN)

container: create_container checkout_container
create_container:
	@echo "#---------------------------------------------------"
	@echo "# 4. Create container"
	@echo "#---------------------------------------------------"
	dvc_create_container	$(DESIGN_CONTR)

checkout_container:
	@echo "#---------------------------------------------------"
	@echo "# 4. Checkout container"
	@echo "#---------------------------------------------------"
	dvc_checkout_container	$(DESIGN_CONTR)

object: checkin_object
checkin_object: 
	@echo "#---------------------------------------------------"
	@echo "# 5. Checkin object into container"
	@echo "#---------------------------------------------------"
	make add_object
	make copy_object
	make copy_folder
	make link_object

add_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-1 Add existing object to container repo"
	@echo "#---------------------------------------------------"
	@for object in $(ADD_OBJECTS) ;  do (\
		if (test -e .design_versn/$(DESIGN_CONTR)/$$object) then \
			echo "dvc_add_object	$(DESIGN_CONTR)	$$object" ; \
			dvc_add_object	$(DESIGN_CONTR)	$$object ; \
		else \
			echo "WARNING: object '$$object' is not found."; \
		fi ;\
	); done


copy_object: $(OBJECT_FILES)
	@echo "#---------------------------------------------------"
	@echo "# 5-2 Copy objects to container"
	@echo "#---------------------------------------------------"
	@for object in $(OBJECT_FILES); do (\
		echo "Copying file '$$object' into container ..."; \
		if (test -e $$object) then \
			dvc_copy_object	$(DESIGN_CONTR)	$$object $$object ; \
		fi ; \
	); done

$(OBJECT_FILES):
	@echo "WARNING: file '$@' does not exist, create a dummy file."
	@echo "`date +%D_$T`" > $@


copy_folder: $(OBJECT_FOLDER)
	@echo "#---------------------------------------------------"
	@echo "# 5-2 Copy folders to container"
	@echo "#---------------------------------------------------"
	@for dir in $(OBJECT_FOLDER); do (\
		echo "Copying directory '$$dir' into container ..."; \
		if (test -d $$dir) then \
			dvc_copy_object	$(DESIGN_CONTR)	$$dir $$dir; \
		else \
			echo "ERROR: $$dir is not a directory"; \
		fi ; \
	); done

$(OBJECT_FOLDER):
	@echo "WARNING: dir '$@' does not exist, create a dummy folder."
	@mkdir -p $@
	@echo "`date +%D_$T`" > $@/HISTORY.txt


link_object: $(OBJECT_LINKS)
	@echo "#---------------------------------------------------"
	@echo "# 5-3 Crearte symbolic link in container"
	@echo "#---------------------------------------------------"
	@for object in $(OBJECT_LINKS); do \
		echo "Linking object '$$object' in container ..."; \
		if (test -e $$object) then \
			dvc_link_object	$(DESIGN_CONTR)	$$object ; \
		fi ; \
	done

$(OBJECT_LINKS):
	@echo "WARNING: link '$@' does not exist, create a dummy file."
	@echo "`date +%D_$T`" > $@

rename_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-4 Rename file in container"
	@echo "#---------------------------------------------------"
	dvc_rename_object	$(DESIGN_CONTR)	$(RENAME_PAIR)  

delete_object:
	@echo "#---------------------------------------------------"
	@echo "# 5-5 Delete files in container"
	@echo "#---------------------------------------------------"
	@for object in $(DEL_OBJECTS) ;  do \
		dvc_delete_object	$(DESIGN_CONTR)	$$object ; \
	done

checkin: checkin_container
checkin_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-7 Checkin all files inside container"
	@echo "#---------------------------------------------------"
	dvc_add_object	$(DESIGN_CONTR)


update: update_container
update_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-8 Update change into container"
	@echo "#---------------------------------------------------"
	dvc_update_container	$(DESIGN_CONTR)


commit: commit_container
commit_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-9 Commit container checkin to SVN server"
	@echo "#---------------------------------------------------"
	dvc_commit_container	$(DESIGN_CONTR)

clean_container:
	@echo "#---------------------------------------------------"
	@echo "# 5-0 Clean up design object in container"
	@echo "#---------------------------------------------------"
	dvc_clean_container 	$(DESIGN_CONTR)


list: list_version list_container
list_version:
	@echo "#---------------------------------------------------"
	@echo "# 6-1 List all data in version"
	@echo "#---------------------------------------------------"
	dvc_list_project -v
	dvc_list_phase -v
	dvc_list_block -v
	dvc_list_stage -v
	dvc_list_version -v

list_container:
	@echo "#---------------------------------------------------"
	@echo "# 6-2 List all data in container"
	@echo "#---------------------------------------------------"
	dvc_list_container -v 

list_env:
	@echo "#---------------------------------------------------"
	@echo "# 6-3 List all variables"
	@echo "#---------------------------------------------------"
	dvc_set_env --local
	dvc_get_env --local --all


clean:
	make remove_container
	make remove_version
	make remove_project
	make clean_files

clean_files:
	@echo "#---------------------------------------------------"
	@echo "# 7-4. Clean up related files in working directory"
	@echo "#---------------------------------------------------"
	rm -fr .dop .project  .container .design_*
	rm -fr $(OBJECT_FILES) $(OBJECT_FOLDER) $(OBJECT_LINKS)

remove_container:
	@echo "#---------------------------------------------------"
	@echo "# 7-1. Clean up container data"
	@echo "#---------------------------------------------------"
	dvc_remove_container	$(DESIGN_CONTR)

remove_version: 
	@echo "#---------------------------------------------------"
	@echo "# 7-2. Clean up design version data"
	@echo "#---------------------------------------------------"
	dvc_remove_version	$(DESIGN_VERSN) $(DESIGN_STAGE)
	dvc_remove_stage	$(DESIGN_STAGE)
	dvc_remove_block	$(DESIGN_BLOCK)
	dvc_remove_phase	$(DESIGN_PHASE)

remove_project:
	@echo "#---------------------------------------------------"
	@echo "# 7-3. Remove proejct repository"
	@echo "#---------------------------------------------------"
	dvc_remove_project	$(DESIGN_PROJT)


SVN_PID	:= $(SVN_ROOT)/svnserve.pid
SVN_LOG	:= $(SVN_ROOT)/svnserve.log

ifdef SVN_MODE
init_server: stop_server
	@mkdir -p $(SVN_ROOT)
	svnserve -d -r $(SVN_ROOT) \
		--listen-host=$(SVN_HOST) --listen-port=$(SVN_PORT) \
		--pid-file=$(SVN_PID) --log-file=$(SVN_LOG)
else
init_server:
	@mkdir -p $(SVN_ROOT)
endif

stop_server:
	@if (test -s $(SVN_PID)) then \
	   kill -9 `cat $(SVN_PID)` ; \
	fi
	@rm -f $(SVN_PID)
