#dvc : Design Version Control
===============================================
Steps:
1) create bin/ directory and link c-shell command script
  % make bin
2) regress test
  % cd run/00_test
  % make test
========================================
- This package is intended to manage the IC design data in a systematic directory structure.
- The underneath version control enginer is SVN server
  * SVN_ROOT : svn server repository root<br>
  * SVN_URL  : svn access mode<br>
     * file local mode - file:://$SVN_ROOT/
     * svn  server mode - svn://localserver:port/$SVN_ROOT
     * http server mode - http://localserver:port/$SVN_ROOT
- Each project has it own repository associated:
  * DESIGN_PROJT : <br>
      Ex. testcase, S10A, ...
- There are 4 levels of directories underneath:
  * Phase : <br>
      Ex. trial , stable, final, tapeout
  * Block : <br>
      Ex. chip, cpu, gpu, ddr, sub1, ...
  * Stage : <br>
      Ex. 000-INIT_DATA, 100-CIRCUIT, 200-SIMULATION, 300-SYNTHESIS, 400-APR, 500-SIGNOFF
  * Version : <br>
      Ex. 2017_0610-xxxx, 2017_0702-xxxx, ...

***
**Project Design Database Directory Structure<br>**
***
*  $SVN_ROOT/ (SVN Database Root Path) <BR>
       * $DESIGN_PROJT/conf (Project Repository Root) <BR>
       * $DESIGN_PHASE/<BR>
       * $DESIGN_BLOCK/<BR>
       * $DESIGN_STAGE/<BR>
       * $DESIGN_VERSN/<BR>
===============================================
Steps:
1) create bin/ directory and link c-shell command script
  % make bin
2) regress test
  % cd run/00_test
  % make test
