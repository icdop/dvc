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

Example:

  * Phase :
	Ex. P1-trial , P2-stable, P3-final, P4-tapeout

  * Block :
	Ex. chip, cpu, gpu, ddr, sub1, ...

  * Stage :
	Ex. 000-DATA, 100-CIRCUIT, 200-LOGIC, 300-DFT, 400-APR, 500-SIGNOFF

  * Version :
	Ex. 2017_0610-xxxx, 2017_0702-xxxx, ...


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
## Design Operation Flow:

1. setup svn file server and project account - CAD/IT

   Example:

	% dvc_set_server SVN_MODE file
	% dvc_init_server start

2. create project respository - Project Manager

   Example:

	% dvc_create_project testcase

3. create design version and prepare initial design data - Design Manager

   Example:

	% dvc_create_version P1-trial/chip/000-DATA/2017_0910-xxx
	% dvc_create_container netlist
	% dvc_copy_object :container /ftp_src/design.v design.v

4. checkout initial design data to working directory - Designer

   Example:

	% dvc_checkout_version P1-trial/chip/000-DATA/2017_0910-xxx --data


4. execute specific design flow - Designer 

   Example:

	% run your own flow

5. submit design quality report for review - Designer

  Example:

	% dvc_create_container     sta
	% dvc_checkout_container   sta
	% dvc_copy_object  	run_sta/sta.log
	% dvc_copy_object  	run_sta/sta.vio.rpt

6. validate design quality report and approve for checkin - Design Manager

7. checkin output result to destinate design folder - Designer

  Example:
 
	% dvc_commit_container

8. release design folder and quality check report - Project Manager


