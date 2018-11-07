# Design Version Control V2018_1107a

## How To install DVC package and setup

### Download DVC package and Create unix environment setup script (Run Once):

Example:

	;######################################################
	;## run the following step once                      ##
	;## install DVC package into /tools/icdop            ##
	;######################################################

	% cd /tools/icdop/
	% git clone https://github.com/icdop/dvc.git

	% cd $HOME
	% /tools/icdop/dvc/setup.cshrc

	=> create CSHRC.dvc under $HOME directory

	;######################################################
	;## source the CSHRC.dvc to acces the DVC utility    ##
	;######################################################

	% source $HOME/CSHRC.dvc

		DVC_HOME = /tools/icdop/dvc


## Design Database Directory Structure

- Under project respository, there are 4 levels of design version directories 

[Directory]:

	$DESIGN_PROJT/		(Project Repository Root)

		$DESIGN_PHASE/
			$DESIGN_BLOCK/
				$DESIGN_STAGE/
					$DESIGN_VERSN/


Phase Name (defined by project manager):

	P1-trial , P2-stable, P3-final, P4-tapeout, ...

Block Name (defined by design manager):

	chip, cpu, gpu, ddr, sub1, ...

Stage Name (defined based on tool execution flow):

	000-DATA,	100-CIRCUIT,	200-LOGIC,	300-DFT,
	400-APR,	500-SIGNOFF,	600-TAPEOUT,	700-TESTING,
	800-PACKAGE,	900-SYSTEM

Version Name (defined by designer, recommend to follow the same convention):  

	<DBSRC_DATE>-<DBDST_WEEK>-<REMARK>
	170910-ww38-ftp
	170910-ww39-scan
	170910-ww40-apr
	170910-ww42-eco

***
## Execution Flow:


### 1. Create project account and root directory

Example:

	- Project Root Directory
	
		PRJ_ROOT = /projects/N13301A
		
	- Project Central Data Directory 

		$PRJ_ROOT/techlib/		: n13301uc0
		$PRJ_ROOT/design/		: n13301ud0
		$PRJ_ROOT/flow/		: n13301uc0
		$PRJ_ROOT/svn/			: n13301ua0

	- Project User Working Directory 
	
		$PRJ_ROOT/users/n13301ua0/	: n13301ua0
		$PRJ_ROOT/users/n13301ub0/	: n13301ub0
		$PRJ_ROOT/users/n13301ub1/	: n13301ub1
		....

### 2. Initialize project specific svn file server (Run If Needed)  - CAD/IT

Example:

	;######################################################
	;## create project specific CSHRC.dvc                ##
	;######################################################

	% vi /projects/N13301A/flow/CSHRC.dvc

	setenv DVC_HOME /tools/icdop/dvc
	setenv PATH     $DVC_HOME/bin:$PATH
	setnev PRJ_ROOT /projects/N13301A
	setenv SVN_ROOT  $PRJ_ROOT/svn
	setenv SVN_MODE  svn
	setenv SVN_HOST  svn_server
	setenv SVN_PORT  13301


	;######################################################
	;## source the CSHRC.dvc to acces the DVC utility    ##
	;######################################################

	% source $PRJ_ROOT/flow/CSHRC.dvc

	- The SVN server is initialized withthe following parameters:

	  $SVN_ROOT : svn repository root path, need to be set first
	
	  $SVN_MODE : svn | file -- server db access mode
	  $SVN_HOST : server host name -- only been used in svn server mode
	  $SVN_PORT : server port name -- only been used in svn server mode
  

	;######################################################
	;## Init SVN DB with file access mode                ##
	;## (only svnadmin can init file server db)          ##
	;######################################################

	% dvc_init_server \
		--root $PRJ_ROOT/svn \
		--mode file


	;######################################################
	;## dvc_create_project   <project_id>                ##
	;######################################################

	% dvc_create_project N13301A

	- When a project is created, there will be one repository under:

	  $SVN_ROOT/<project_id>/

	- Project config files are copied from $DVC_HOME/etc/conf/:

	  $SVN_ROOT/<project_id>/conf/
      

	;######################################################
	;## Start a SVN server for other members to access   ##
	;######################################################

	% dvc_init_server \
		--root $PRJ_ROOT/svn \
		--mode svn \
		--host $SVN_HOST -port $SVN_PORT


### 3. Create design folder for members to checkin data - Technical Lead

Example:

	;######################################################
	;## source the CSHRC.dvc to acces the DVC utility    ##
	;######################################################

	% source /projects/N13301A/flow/CSHRC.dvc

	;######################################################
	;## dvc_checkout_project   <proj_name> [<local_path>]##
	;######################################################
	% dvc_checkout_project N13301A _

	;######################################################
	;## dvc_create_folder   <phase>/<block>/<stage>/<version>
	;######################################################

	% dvc_create_folder   P1-trial/block1/000-DATA/170910-ww38-place


### 4. Checkin design data into design folder - Designer

Example:

	;######################################################
	;## source the CSHRC.dvc to acces the DVC utility    ##
	;######################################################

	% source /projects/N13301A/flow/CSHRC.dvc

	;######################################################
	;## dvc_checkout_project   <proj_name> [<local_path>]##
	;######################################################
	% dvc_checkout_project N13301A _

	% dvc_checkout_folder P1-trial/block1/000-DATA/170910-ww38-place

	% dvc_copy_object /some_rundir_path/design.v       design.v
	% dvc_link_object /some_rundir_path/design.spef.gz design.spef.gz

	% dvc_list_folder [--recursive]

	% dvc_checkin_folder


