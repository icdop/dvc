==============================
How does a plugin in work:
==============================

0) Need to have a design folder to copy report files into  

  The target folder is ":version" which will created once a design version is checkout


*** Execute the following steps in Makefile sequentially

1) import : import report/log file into design folder

  - using stardard script and setup file to import data

DESIGN_FILES:  +  script/import.awk

;var_name	target_filename		source_file_location
STA_LOG

- usr can also prepare customized script to copy data (ex. mmmc has many report files)

2) check : check if required file is in place

REQUIRE_FILES: + script/check.csh

3) run : DQI extaction script

  run.csh => DQI.rpt  with the following format

  <DQI_name> <DQI_vaule>


4) save : save DQI into design database folder


  - saveDQI.awk call the following command
 
   % dvc_set_dqi  <DQI_name> <DQI_value>

5) html : generate html report using predefined template
 
  - dvc_report_version --html plugin/html/


==============================
How to prepare a plugin:
==============================

- Makefile
- DESIGN_FILES
- REQUIRE_FILES
- help.txt
- html/*
- script/*

