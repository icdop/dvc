# dvc : Design Version Control

- This package is intended to manage the IC design data in a systematic directory structure.

- The underneath version control enginer is SVN server
  * SVN_ROOT : svn server repository root<br>
  * SVN_URL  : svn access URL <br>
     * svn  server - svn://localserver:port/$SVN_ROOT
     * http server - http://localserver:port/$SVN_ROOT
     * file system - file:://$SVN_ROOT/
     
- Each project has it own repository associated:
  * $SVN_ROOT/$DESIGN_PROJT/ : <br>
      Ex. testcase, S10A, ...
      
- There are 4 levels of directories under project respository
  * Phase : <br>
      Ex. P1-trial , P2-stable, P3-final, P4-tapeout
  * Block : <br>
      Ex. chip, cpu, gpu, ddr, sub1, ...
  * Stage : <br>
      Ex. 000-INIT_DATA, 100-CIRCUIT, 200-SIMULATION, 300-SYNTHESIS, 400-APR, 500-SIGNOFF
  * Version : <br>
      Ex. 2017_0610-xxxx, 2017_0702-xxxx, ...

***
** Project Design Database Directory Structure<br>**
*  $SVN_ROOT/ (SVN Database Root Path) <BR>
       * $DESIGN_PROJT/conf (Project Repository Root) <BR>
         * $DESIGN_PHASE/<BR>
           * $DESIGN_BLOCK/<BR>
             * $DESIGN_STAGE/<BR>
               * $DESIGN_VERSN/<BR>

***
** Design Operation Flow:

1. setup svn server and project account - CAD/IT
2. create project respository - Project Manager
3. create design version and prepare design data - Design Manager
3. checkout source design data to local disk - Designer
4. execute specific design flow - Designer 
5. submit design quality report (dqi) for review - Designer
6. validate design quality report and approve - Design Manager
7. checkin design output data to destinate design folder - Designer
8. complete design quality check - QA

