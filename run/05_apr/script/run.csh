#!/bin/csh -f
set dqi_list="F01-LEC P01-Func_max P02-Func_min P03-Scan_min P04-Power P05-Noise L01-Short L02-DRC R01-EM R02-IR"
set block_list="chip block1 block2 block3 block4 block5"

### 1. Setup svn file server 

dvc_init_server --root $HOME/svn_root --mode file

### 2. Create project respository - Project Manager

dvc_create_project 05_apr

dvc_checkout_project --force 05_apr _
### 3. Create design version folder and checkin design data - Design Manager
dvc_create_phase P1-trial
dvc_checkout_phase
dvc_set_dqi --root :phase F01-LEC      0
dvc_set_dqi --root :phase P01-Func_max 0
dvc_set_dqi --root :phase P02-Func_min 0
dvc_set_dqi --root :phase P03-Scan_min 0
dvc_set_dqi --root :phase P04-Power    0
dvc_set_dqi --root :phase P05-Noise    0
dvc_set_dqi --root :phase L01-Short    0
dvc_set_dqi --root :phase L02-DRC      0
dvc_set_dqi --root :phase R01-EM       0
dvc_set_dqi --root :phase R02-IR       0
  
  foreach block($block_list)
    dvc_create_block $block
    dvc_checkout_block
    foreach dqi_name ($dqi_list)
      dvc_set_dqi --root :block $dqi_name `date +%S`
    end
    dvc_checkin_block
  end

dvc_create_design P1-trial/chip/400-APR/2017_0912-xxx
dvc_checkout_design 
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

dvc_checkin_design

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

