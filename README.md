# Design Version Control V2017.09

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


- The version control mechanism is SVN server

  * SVN_ROOT : svn repository root path

  * SVN_URL  : svn access mode

     * svn  server - svn://server:port/

     * file access - file:://$SVN_ROOT/

     
- Each project has it own repository under:

  * $SVN_ROOT/$DESIGN_PROJT/

- Initial server config files are copied from dvc/etc/conf

  * $SVN_ROOT/$DESIGN_PROJT/conf/
      

***
## Design Version Management Flow:

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


