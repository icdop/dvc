#!/bin/csh -f

### 1. Setup svn file server and project account - CAD/IT

dvc_init_server file

### 2. Create project respository - Project Manager

dvc_create_project 04_sta

dvc_checkout_project --force 04_sta

### 3. Create design version folder and checkin design data - Design Manager

dvc_create_design    P1-trial/chip/400-APR/2017_0910-xxx
dvc_checkout_design  
  cp data/design.v   :version/design.v
  cp data/design.sdc :version/design.sdc
  cp data/chip.jpg   :version/chip.jpg
  
  dvc_set_dqi  --root :version Width 100  
  dvc_set_dqi  --root :version Height 150  
  dvc_set_dqi  --root :version Area  15  
  dvc_set_dqi  --root :version Congestion  0.01%
  dvc_set_dqi  --root :version WNS  -100
  dvc_set_dqi  --root :version NVP  1000
  dvc_set_dqi  --root :version DRC   500
dvc_checkin_design

dvc_create_stage     520-sta
dvc_checkout_stage   520-sta
set version_list = "2017_0910-xxx 2017_0912-yyy 2017_0914-zzz"
foreach version ($version_list)
  dvc_create_version $version
  dvc_checkout_version $version
    cp data/design.v   :version/design.v
    cp data/design.sdc :version/design.sdc
    cp data/chip.jpg   :version/chip.jpg
    dvc_set_dqi  WNS  -100
    dvc_set_dqi  NVP  1000
    dvc_set_dqi  DRC   500
  dvc_checkin_version

  set scenario_list = "001 002 003 004"
  foreach scenario ($scenario_list) 
    dvc_create_container  $scenario
    dvc_checkout_container $scenario
      dvc_copy_object report/sta.rpt  sta.rpt
      dvc_link_object report/sta.log  sta.log
      dvc_set_dqi  WNS  `date +%M`
      dvc_set_dqi  NVP  `date +%S`
    dvc_checkin_container
  end
end




