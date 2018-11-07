# Design Version Control V2018_1107.dev

## Version Control Engine -- Subversion

- The SVN server is initialized withthe following parameters:

	  $SVN_ROOT : svn repository root path, need to be set first
  
	  $SVN_MODE : svn | file -- server db access mode
	  $SVN_HOST : server host name -- only been used in svn server mode
	  $SVN_PORT : server port name -- only been used in svn server mode
  
- When a project is createed, there will be one repository under:

	  $SVN_ROOT/<project_name>/

- Project config files are copied from $DVC_HOME/etc/conf/:

	  $SVN_ROOT/<project_name>/conf/
      

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
### 0. Create Unix Environment setup script:

Example:

	;
	; run the following step once
	; install DVC package in /tools/icdop
	;
	% cd /tools/icdop
	% git clone https://github.com/icdop/dvc.git
	% cd dvc
	% /tools/icdop/dvc/setup.cshrc
	=> create CSHRC.dvc under /tools/icdop/dvc/ directory

	;
	; source the CSHRC.dvc to acces the DVC utility
	;
	% source /tools/icdop/dvc/CSHRC.dvc

### 1. Setup svn file server and project account - CAD/IT

Example:

	; start server with file access mode
	% dvc_init_server \
		--root /home/owner/proj_svn \
		--mode file

	; start server with svn server mode
	% dvc_init_server \
		--root /home/owner/proj_svn \
		--mode svn --host <localhost> -port 3690


### 2. Create project respository - Project Manager

Example:

	% dvc_create_project <proj_name>


### 3. Create design folder and checkin design data - Designer

Example:

	% dvc_checkout_project <proj_name>
	
	#
	# dvc_create_design   <phase>/<block>/<stage>/<version>
	#
	% dvc_create_design   P1-trial/chip/000-DATA/170910-ww38-ftp

	% dvc_checkout_design P1-trial/chip/000-DATA/170910-ww38-ftp

	% dvc_copy_object /some_rundir_path/design.v       design.v
	% dvc_link_object /some_rundir_path/design.spef.gz design.spef.gz

	% dvc_checkin_design 


