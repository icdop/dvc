BIN_PATH := bin
CSH_PATH := ../csh

bin: csh/*
	mkdir -p $(BIN_PATH)
	rm -f $(BIN_PATH)/dvc_*
	ln -f -s $(CSH_PATH)/00_set_env.csh			$(BIN_PATH)/dvc_set_env
	ln -f -s $(CSH_PATH)/01_set_dqi.csh			$(BIN_PATH)/dvc_set_dqi
	ln -f -s $(CSH_PATH)/02_set_server.csh			$(BIN_PATH)/dvc_set_server
	ln -f -s $(CSH_PATH)/03_set_project.csh			$(BIN_PATH)/dvc_set_project
	ln -f -s $(CSH_PATH)/04_set_version.csh			$(BIN_PATH)/dvc_set_version
	ln -f -s $(CSH_PATH)/05_set_container.csh		$(BIN_PATH)/dvc_set_container
	ln -f -s $(CSH_PATH)/10_get_env.csh			$(BIN_PATH)/dvc_get_env
	ln -f -s $(CSH_PATH)/11_get_dqi.csh			$(BIN_PATH)/dvc_get_dqi
	ln -f -s $(CSH_PATH)/12_get_server.csh			$(BIN_PATH)/dvc_get_server
	ln -f -s $(CSH_PATH)/13_get_project.csh			$(BIN_PATH)/dvc_get_project
	ln -f -s $(CSH_PATH)/14_get_version.csh			$(BIN_PATH)/dvc_get_version
	ln -f -s $(CSH_PATH)/20_create_project.csh		$(BIN_PATH)/dvc_create_project
	ln -f -s $(CSH_PATH)/21_create_phase.csh		$(BIN_PATH)/dvc_create_phase
	ln -f -s $(CSH_PATH)/22_create_block.csh		$(BIN_PATH)/dvc_create_block
	ln -f -s $(CSH_PATH)/23_create_stage.csh		$(BIN_PATH)/dvc_create_stage
	ln -f -s $(CSH_PATH)/24_create_version.csh		$(BIN_PATH)/dvc_create_version
	ln -f -s $(CSH_PATH)/25_create_container.csh		$(BIN_PATH)/dvc_create_container
	ln -f -s $(CSH_PATH)/30_checkout_project.csh		$(BIN_PATH)/dvc_checkout_project
	ln -f -s $(CSH_PATH)/31_checkout_phase.csh		$(BIN_PATH)/dvc_checkout_phase
	ln -f -s $(CSH_PATH)/32_checkout_block.csh		$(BIN_PATH)/dvc_checkout_block
	ln -f -s $(CSH_PATH)/33_checkout_stage.csh		$(BIN_PATH)/dvc_checkout_stage
	ln -f -s $(CSH_PATH)/34_checkout_version.csh		$(BIN_PATH)/dvc_checkout_version
	ln -f -s $(CSH_PATH)/35_checkout_container.csh		$(BIN_PATH)/dvc_checkout_container
	ln -f -s $(CSH_PATH)/40_list_project.csh		$(BIN_PATH)/dvc_list_project
	ln -f -s $(CSH_PATH)/41_list_phase.csh			$(BIN_PATH)/dvc_list_phase
	ln -f -s $(CSH_PATH)/42_list_block.csh			$(BIN_PATH)/dvc_list_block
	ln -f -s $(CSH_PATH)/43_list_stage.csh			$(BIN_PATH)/dvc_list_stage
	ln -f -s $(CSH_PATH)/44_list_version.csh		$(BIN_PATH)/dvc_list_version
	ln -f -s $(CSH_PATH)/45_list_container.csh		$(BIN_PATH)/dvc_list_container
	ln -f -s $(CSH_PATH)/48_list_tree.csh			$(BIN_PATH)/dvc_list_tree
	ln -f -s $(CSH_PATH)/49_list_dir.csh			$(BIN_PATH)/dvc_list_dir
	ln -f -s $(CSH_PATH)/51_add_object.csh			$(BIN_PATH)/dvc_add_object
	ln -f -s $(CSH_PATH)/52_copy_object.csh			$(BIN_PATH)/dvc_copy_object
	ln -f -s $(CSH_PATH)/53_link_object.csh			$(BIN_PATH)/dvc_link_object
	ln -f -s $(CSH_PATH)/54_rename_object.csh		$(BIN_PATH)/dvc_rename_object
	ln -f -s $(CSH_PATH)/55_delete_object.csh		$(BIN_PATH)/dvc_delete_object
	ln -f -s $(CSH_PATH)/56_update_container.csh		$(BIN_PATH)/dvc_update_container
	ln -f -s $(CSH_PATH)/57_commit_container.csh		$(BIN_PATH)/dvc_commit_container
	ln -f -s $(CSH_PATH)/59_clean_container.csh		$(BIN_PATH)/dvc_clean_container
	ln -f -s $(CSH_PATH)/64_checkin_version.csh		$(BIN_PATH)/dvc_checkin_version
	ln -f -s $(CSH_PATH)/65_checkin_container.csh		$(BIN_PATH)/dvc_checkin_container
	ln -f -s $(CSH_PATH)/84_refresh_version.csh		$(BIN_PATH)/dvc_refresh_version
	ln -f -s $(CSH_PATH)/88_refresh_index.csh		$(BIN_PATH)/dvc_refresh_index
	ln -f -s $(CSH_PATH)/99_init_server.csh			$(BIN_PATH)/dvc_init_server
	ln -f -s $(CSH_PATH)/x0_remove_project.csh		$(BIN_PATH)/dvc_remove_project
	ln -f -s $(CSH_PATH)/x1_remove_phase.csh		$(BIN_PATH)/dvc_remove_phase
	ln -f -s $(CSH_PATH)/x2_remove_block.csh		$(BIN_PATH)/dvc_remove_block
	ln -f -s $(CSH_PATH)/x3_remove_stage.csh		$(BIN_PATH)/dvc_remove_stage
	ln -f -s $(CSH_PATH)/x4_remove_version.csh		$(BIN_PATH)/dvc_remove_version
	ln -f -s $(CSH_PATH)/x5_remove_container.csh		$(BIN_PATH)/dvc_remove_container

