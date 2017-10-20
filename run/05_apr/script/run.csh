#!/bin/csh -f

### 1. Setup svn file server 

dvc_init_server start

### 2. Create project respository - Project Manager

dvc_create_project 05_apr

### 3. Create design version folder and checkin design data - Design Manager

dvc_create_design P1-trial/chip/400-APR/2017_0912-xxx

dvc_checkout_project 05_apr
dvc_checkout_design  P1-trial/chip/400-APR/2017_0912-xxx
cp data/design.v   :version/design.v
cp data/design.sdc :version/design.sdc
cp report/chip.jpg :version/chip.jpg

dvc_set_dqi  Width     100  
dvc_set_dqi  Height    150  
dvc_set_dqi  Area      15  
dvc_set_dqi  VCongest  0.01%
dvc_set_dqi  HCongest  0.02%
dvc_set_dqi  DRC   	500
dvc_set_dqi  WNS  	-100
dvc_set_dqi  TNS  	-1000
dvc_set_dqi  NVP  	1000
dvc_set_dqi  REG2REG/WNS  -100
dvc_set_dqi  REG2REG/TNS  -1000
dvc_set_dqi  REG2REG/NVP  1000
dvc_set_dqi  REG2MACRO/WNS  -100
dvc_set_dqi  REG2MACRO/TNS  -1000
dvc_set_dqi  REG2MACRO/NVP  1000
dvc_set_dqi  MACRO2REG/WNS  -100
dvc_set_dqi  MACRO2REG/TNS  -1000
dvc_set_dqi  MACRO2REG/NVP  1000
dvc_set_dqi  ICG_GEN/WNS  -100
dvc_set_dqi  ICG_GEN/TNS  -1000
dvc_set_dqi  ICG_GEN/NVP  1000
dvc_checkin_version

  set step_list = "preplace place cts route postroute"
  foreach step ($step_list) 
    dvc_create_container  $step
    dvc_checkout_container
    dvc_copy_object report/sta.rpt  sta.rpt
    dvc_copy_object report/apr.log  apr.log
    
    if {(test -f report/$step.jpg)} then
       dvc_copy_object report/$step.jpg
    endif 
    
    dvc_set_dqi  Runtime  `date +%S`
    dvc_set_dqi  WNS  -100
    dvc_set_dqi  TNS  -1000
    dvc_set_dqi  NVP  1000
    dvc_set_dqi  REG2REG/WNS  -100
    dvc_set_dqi  REG2REG/TNS  -1000
    dvc_set_dqi  REG2REG/NVP  1000
    dvc_set_dqi  REG2MACRO/WNS  -100
    dvc_set_dqi  REG2MACRO/TNS  -1000
    dvc_set_dqi  REG2MACRO/NVP  1000
    dvc_set_dqi  MACRO2REG/WNS  -100
    dvc_set_dqi  MACRO2REG/TNS  -1000
    dvc_set_dqi  MACRO2REG/NVP  1000
    dvc_set_dqi  ICG_GEN/WNS  -100
    dvc_set_dqi  ICG_GEN/TNS  -1000
    dvc_set_dqi  ICG_GEN/NVP  1000
    dvc_checkin_container
  end



