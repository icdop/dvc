# Design Version Control V2017

- Utility to manage chip design data using SVN server

## Design Database Directory Structure

- There are 4 levels of directories under project respository

Directory:

	$DESIGN_PROJT/		(Project Repository Root)

		$DESIGN_PHASE/
			$DESIGN_BLOCK/
				$DESIGN_STAGE/
					$DESIGN_VERSN/


* Phase:

	P1-trial , P2-stable, P3-final, P4-tapeout

* Block:

	chip, cpu, gpu, ddr, sub1, ...

* Stage:

	000-DATA, 100-CIRCUIT, 200-LOGIC, 300-DFT, 400-APR, 500-SIGNOFF

* Version:

	2017_0610-xxxx, 2017_0702-xxxx, ...


- The SVN server is the underneath version control engine:

  * SVN_ROOT : svn repository root path, need to be set first
  
  * SVN_MODE : svn | file -- server db access mode
  * SVN_HOST : server host name -- only been used in svn server mode
  * SVN_PORT : server port name -- only been used in svn server mode
  
- When a project is createed, there will be one repository under:

  * $SVN_ROOT/<project_name>/

- Initial server config files are copied from dvc/etc/conf:

  * $SVN_ROOT/<project_name>/conf/
      

***
## Design Version Management Flow:

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

	; check server status
	% dvc_init_server status

### 2. Create project respository - Project Manager

Example:

	% dvc_create_project <proj_name>


### 3. Create design folder and checkin design data - Designer

Example:

	% dvc_checkout_project <proj_name>
	
	; dvc_create_design   <phase>/<block>/<stage>/<version>
	% dvc_create_design   P1-trial/chip/000-DATA/2017_0910-ww38

	% dvc_checkout_design P1-trial/chip/000-DATA/2017_0910-ww38

	% dvc_copy_object /some_rundir_path/design.v       design.v
	% dvc_link_object /some_rundir_path/design.spef.gz design.spef.gz

	% dvc_checkin_design 


***
Recommended Phase Name:

	;NAME           DESCRIPTION
	;============   ========================== 
	P1-trial        "Design Initial Trial Run Phase "
	P2-stable       "Design Stable Run Phase "
	P3-final        "Design Final Run Phase "
	P4-validation   "Silicon Valiation Phase "
	P5-production   "Silicon Production Phase "


Recommended Stage Name:

	;NAME           DESCRIPTION
	;============   ========================== 
	000-DATA        "Initial Design Data"
	100-CIRCUIT     "Circuit Design Stage"
	200-LOGIC       "Logic Verfication Stage"
	300-DFT         "Design For Test"
	400-APR         "Auto Place & Route"
	500-SIGNOFF     "Signoff Stage"
	600-TAPEOUT     "Tapeout Stage"
	700-TESTING     "Wafer Testing Stage"
	800-PACKAGE     "Package Stage"
	900-SYSTEM      "System Validation Stage"

Recommended Verson Name:

	<DB_SOURCE_DATE>-<DB_CHECKIN_WEEK>-<REMARK>
	170910-ww38-jay
	170910-ww39-scan
	170910-ww40-place
	170910-ww41-route
	170910-ww42-eco1
	170910-ww42-eco2
