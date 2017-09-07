# Design Version Control

- DVC utility is intended to manage chip design data in a predefined directory structure.

## Project Design Database Directory Structure**

Example:

	$SVN_ROOT/ (SVN Database Root Path)
		$DESIGN_PROJT/conf (Project Repository Root)
			$DESIGN_PHASE/
				$DESIGN_BLOCK/
					$DESIGN_STAGE/
						$DESIGN_VERSN/

- The underneath version control engine is SVN server

  * SVN_ROOT : svn repository root

  * SVN_URL  : svn access mode

     * svn  server - svn://localserver:port/$SVN_ROOT

     * file access - file:://$SVN_ROOT/
     
- Each project has it own repository:

  * $DESIGN_PROJT/conf/ :

	Initial config files are copied from dvc/etc/conf

      
- There are 4 levels of directories under project respository

  * Phase :
	Ex. P1-trial , P2-stable, P3-final, P4-tapeout

  * Block :
	Ex. chip, cpu, gpu, ddr, sub1, ...

  * Stage :
	Ex. 000-INIT_DATA, 100-CIRCUIT, 200-LOGIC, 300-DFT, 400-APR, 500-SIGNOFF

  * Version :
	Ex. 2017_0610-xxxx, 2017_0702-xxxx, ...

***
## Design Operation Flow:

1. setup svn file server and project account - CAD/IT

2. create project respository - Project Manager

3. create design version and prepare initial design data - Design Manager

3. checkout initial design data to working directory - Designer

4. execute specific design flow - Designer 

5. submit design quality report for review - Designer

6. validate design quality report and approve for checkin - Design Manager

7. checkin output result to destinate design folder - Designer

8. release design folder and quality check report - Project Manager


