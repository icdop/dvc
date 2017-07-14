BIN_PATH := bin
CSH_PATH := ../csh

help:
	@echo "Usage: make bin"

	
bin:
	mkdir -p $(BIN_PATH)
	rm -f $(BIN_PATH)/dvc_*
	ln -f -s $(CSH_PATH)/00_set_env.csh			$(BIN_PATH)/dvc_set_env
	ln -f -s $(CSH_PATH)/01_set_svn.csh			$(BIN_PATH)/dvc_set_svn
	ln -f -s $(CSH_PATH)/02_set_version.csh			$(BIN_PATH)/dvc_set_version
	ln -f -s $(CSH_PATH)/10_get_env.csh			$(BIN_PATH)/dvc_get_env
	ln -f -s $(CSH_PATH)/11_get_svn.csh			$(BIN_PATH)/dvc_get_svn
	ln -f -s $(CSH_PATH)/12_get_version.csh			$(BIN_PATH)/dvc_get_version
	ln -f -s $(CSH_PATH)/20_create_project.csh		$(BIN_PATH)/dvc_create_project
	ln -f -s $(CSH_PATH)/21_create_phase.csh		$(BIN_PATH)/dvc_create_phase
	ln -f -s $(CSH_PATH)/22_create_block.csh		$(BIN_PATH)/dvc_create_block
	ln -f -s $(CSH_PATH)/23_create_stage.csh		$(BIN_PATH)/dvc_create_stage
	ln -f -s $(CSH_PATH)/24_create_version.csh		$(BIN_PATH)/dvc_create_version
	ln -f -s $(CSH_PATH)/50_container_checkout.csh		$(BIN_PATH)/dvc_container_checkout
	ln -f -s $(CSH_PATH)/51_container_add_obj.csh		$(BIN_PATH)/dvc_container_add_obj
	ln -f -s $(CSH_PATH)/52_container_cp_obj.csh		$(BIN_PATH)/dvc_container_cp_obj
	ln -f -s $(CSH_PATH)/53_container_ln_obj.csh		$(BIN_PATH)/dvc_container_ln_obj
	ln -f -s $(CSH_PATH)/54_container_mv_obj.csh		$(BIN_PATH)/dvc_container_mv_obj
	ln -f -s $(CSH_PATH)/55_container_rm_obj.csh		$(BIN_PATH)/dvc_container_rm_obj
	ln -f -s $(CSH_PATH)/56_container_list.csh		$(BIN_PATH)/dvc_container_list
	ln -f -s $(CSH_PATH)/58_container_update.csh		$(BIN_PATH)/dvc_container_update
	ln -f -s $(CSH_PATH)/59_container_commit.csh		$(BIN_PATH)/dvc_container_commit
	ln -f -s $(CSH_PATH)/5x_container_empty.csh		$(BIN_PATH)/dvc_container_empty
	ln -f -s $(CSH_PATH)/x0_remove_project.csh		$(BIN_PATH)/dvc_remove_project
	ln -f -s $(CSH_PATH)/x1_remove_phase.csh		$(BIN_PATH)/dvc_remove_phase
	ln -f -s $(CSH_PATH)/x2_remove_block.csh		$(BIN_PATH)/dvc_remove_block
	ln -f -s $(CSH_PATH)/x3_remove_stage.csh		$(BIN_PATH)/dvc_remove_stage
	ln -f -s $(CSH_PATH)/x4_remove_version.csh		$(BIN_PATH)/dvc_remove_version
	ln -f -s $(CSH_PATH)/x5_remove_container.csh		$(BIN_PATH)/dvc_remove_container
