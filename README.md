# Design Version Control V2017.1012

- Utility to manage chip design data in a pre-defined directory structure

## Design Database Directory Structure
- There are 4 levels of directories under project respository

Directory:

	$DESIGN_PROJT/		(Project Repository Root)
		$DESIGN_PHASE/
			$DESIGN_BLOCK/
				$DESIGN_STAGE/
					$DESIGN_VERSN/


* Phase :

	P1-trial , P2-stable, P3-final, P4-tapeout

* Block :

	chip, cpu, gpu, ddr, sub1, ...

* Stage :

	000-DATA, 100-CIRCUIT, 200-LOGIC, 300-DFT, 400-APR, 500-SIGNOFF

* Version :

	2017_0610-xxxx, 2017_0702-xxxx, ...


- The SVN server is the underneath version control engine

  * SVN_ROOT : svn repository root path, need to be set first
  
  * SVN_MODE : svn | file -- server db access mode
  * SVN_HOST : server host name -- only been used in svn server mode
  * SVN_PORT : server port name -- only been used in svn server mode
  
  * SVN_URL  : svn access URL string, based on different access mode, it has different format

     * svn  server - svn://server:port/

     * file access - file:://$SVN_ROOT/

     
- When a project is createed, there will be one repository under:

  * $SVN_ROOT/<project_name>

- Initial server config files are copied from dvc/etc/conf

  * $SVN_ROOT/<project_name>/conf/
      

***
## Design Version Management Flow:

### 1. Setup svn file server and project account - CAD/IT

Example:

	; set server configuration variable
	% dvc_set_server SVN_ROOT /home/owner/proj_svn
	
	% dvc_set_server SVN_MODE file
	or
	% dvc_set_server SVN_MODE svn
	% dvc_set_server SVN_HOST localhost
	% dvc_set_server SVN_PORT 3690

	; start server
	% dvc_init_server start	

### 2. Create project respository - Project Manager

Example:

	% dvc_create_project testcase


### 3. Create design version folder and checkin design data - Designer

Example:

	% dvc_checkout_project testcsse
	
	% dvc_create_design P1-trial/chip/000-DATA/2017_0910-xxx

	% dvc_checkout_design P1-trial/chip/000-DATA/2017_0910-xxx

	% dvc_copy_object /some_source_path/design.v design.v

	% dvc_checkin_design 


