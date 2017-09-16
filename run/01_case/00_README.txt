# ========================================================
# DVC Simple Case Example:
# ========================================================

### 1. Setup svn file server and project account - CAD/IT

Example:

	; set server configuration variable
	% dvc_set_server SVN_ROOT /home/owner/proj_svn
	% dvc_set_server SVN_MODE file

	; start server
	% dvc_init_server start	

### 2. Create project respository - Project Manager

Example:

	% dvc_create_project testcase


### 3. Create design version folder and checkin design data - Design Manager

Example:

	% dvc_create_version P1-trial/chip/000-DATA/2017_0910-xxx

	% dvc_checkout_version P1-trial/chip/000-DATA/2017_0910-xxx

	% dvc_copy_object :version /ftp_path/design.v design.v

	% dvc_checkin_version 


