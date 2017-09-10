*********************************************************
# DVC (Design Version Control) Specification
*********************************************************
* V1.0  2017/06/08 By Albert Li
*       use 4+1 level directory
* V1.1  2017/06/09 By Albert Li
*       revere back to 4 level directory, remove parition level
* V1.2  2017/06/13 By Albert Li
*       use svn to implement a sampel code
* V1.3  2017/06/14 By Albert Li
*       add regressiion test
* V1.4  2017/06/28 By Albert Li
*       create dvc (design version control) sub-module 
* V2.0  2017/08/12 By Albert Li
*       add container level under design version
* V2.1  2017/09/09 By Albert Li
*       re-defined the .dvc/ configuration file
* 

********************************************************
# Global Variables
********************************************************

* ----------------------------
* DVC Server Variable
* ----------------------------

  * Variable are stored in the config directory(.dop/server/)

  * SVN respository root

     SVN_ROOT = /home/owner/proj_svn

  * SVN server mode URL (file, http, svn)

     SVN_URL = file://$SVN_ROOT
     SVN_URL = svn://localhost:port/$SVN_ROOT
     SVN_URL = http://localhost:port/$SVN_ROOT (not supported yet)

* ============================
* Global Variable Access
* ============================

  * Global Variables are stored in the config directory(.dop/env/)

    Example: Search path sequency is as below:

    1. Local : "$PWD/.dop/env/*VARNAME*"
       % dvc_set_env --local  

    2. Global : "$HOME/.dop/env/*VARNAME*"
       % dvc_set_env --global  

  * Global DESIGN Variables

	  DESIGN_PROJT = testcase
	  DESIGN_PHASE = P1-trial
	  DESIGN_BLOCK = chip
	  DESIGN_STAGE = 000-INIT_DATA
	  DESIGN_VERSN = 2017_0610-XXXX
	  DESIGN_CONTR = netlist

********************************************************
# Project Design Directory Structure
********************************************************

* SVN Repository directory in unix file system

  ** create_project

	$SVN_ROOT/ (SVN Database Root Path)
		$DESIGN_PROJT/(Project Root)
				conf/ (configuration file)

* Directory view within server db after create_version
  
  ** create_version
	
	/$DESIGN_PHASE/.dvc
       		/$DESIGN_BLOCK/.dvc
			/$DESIGN_STAGE/.dvc
				/$DESIGN_VERSN/.dvc

  ** create_container

	/$phase	/$block	/$stage	/$versn	/$DESIGN_CONTR/.dqi


* Design Directory in local working directory after checkout 

  ** checkuot_project : project root directory is checkout

	.project/
		.dvc/

  ** checkout_version : following directories are checkout

	.project/
		: -> $current_phase
		.dvc/
		$DESIGN_PHASE/
			: -> $current_block
			.dvc/
       			$DESIGN_BLOCK/
				: -> $current_stage
				.dvc/
				$DESIGN_STAGE/
					: -> $current_version
					.dvc/
					$DESIGN_VERSN/
						.dvc/

	.design_block -> .project/$phase/$block
	.design_stage -> .project/$phase/$block/$stage
	.design_versn -> .project/$phase/$block/$stage/$version

  ** checkout_container : following directory is checkout

	.design_versn/
		$DESIGN_CONTR/
			.dqi/
	.container -> .dvc_version/$DESIGN_CONTR


* ========================================================
# Design Folder Configuration (.dvc/)
* ========================================================

## 1. README.md file is created in each design folder

  ** ------------------------------------
  ** README.md (project/.dvc/)
  ** ------------------------------------

	* Design Version Control Directory
	=======================================
	* Project : testcase
	* Path    : .project/testcase/
	* Author  : username
	* Date    : 20170812_183836
	=======================================

## 2. External plugin program definition file 

  ** ------------------------------------
  ** FILE_PLUGINS ($project/.dvc/)
  ** ------------------------------------

  Example: (etc/rule/FILE_PLUGINS)

	;FILE		NAME_RULE	ACTIONS
	;=============   =========	================
	VERILOG		{*.vg}		{view "less $1"} {edit "vi $1"}
	DEF		{*.def}		{view "less $1"}
	RPT		{*.rpt}		{view "less $1"}
	LOG		{*.log}		{view "less $1"} 
	SCRIPT		{*.csh}		{run "csh $1"} {edit "vi $1"}
	COMMAND		{*.exe}		{run "exec $1"}

## 3. Design files required for version folder

  ** ------------------------------------
  ** DESIGN_FILES ($version/.dvc/)
  ** ------------------------------------

  Example: (etc/rule/DESIGN_FILES)

	;VAR_NAME	FORMAT	DEFAULT		DESCRIPTION
	;==============	======	=======		===========================
	V_FILE		VERILOG	design.vg	"Verilog Netlist File"
	DEF_FILE	DEF	design.def	"Physical Design Data"
	SPEF_FILE	SPEF	design.spef	"RC Extraction Data"
	PT_STA_LOG	LOG	pt_sta.log	"STA Run Logfile"

## 4. Sub folder naming rule

  ** ------------------------------------------
  ** $project/.dvc/SUB_FOLDER_RULE 
  ** ------------------------------------------

  Example: (etc/rule/DEFINE_PAHSE)

	;NAME           TITLE
	;=============	===========================
	P1-trial	"Initial Trial Run Phase "
	P2-stable	"Stable Run Phase "
	P3-final	"Final Run Phase "
	P4-production	"Production Run Phase "


  ** ------------------------------------------
  ** $block/.dvc/SUB_FOLDER_RULE 
  ** ------------------------------------------

  Example: (etc/rule/DEFINE_STAGE)

	;NAME           TITLE
	============    ========================== 
	000-INIT_DATA   "Initial Design Data"
	100-CIRTUIT	"Circuit Design Stage"
	200-FUNCTION	"Function Verfication Stage"
	300-DFT         "Design For Test Stage"
	400-APR         "Auto Place & Route Stage"
	500-SIGNOFF     "Signoff Stage"
	600-TAPEOUT     "Tapeout Stage"
	700-TESTING	"Testing Stage"
	800-PACKAGE	"Package Stage"
	900-SYSTEM	"System Verification Stage"
