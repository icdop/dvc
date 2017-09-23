#!/bin/csh -f

### 1. Setup svn file server and project account - CAD/IT

dvc_set_server SVN_ROOT $HOME/proj_svn
dvc_set_server SVN_MODE file

dvc_init_server start

### 2. Create project respository - Project Manager

dvc_create_project testcase

### 3. Create design version folder and checkin design data - Design Manager

dvc_create_version P1-trial/chip/400-APR/2017_0912-xxx

dvc_checkout_version  P1-trial/chip/400-APR/2017_0912-xxx
cp data/design.v   :version/design.v
cp data/design.sdc :version/design.sdc
cp report/chip.jpg :version/chip.jpg

dvc_set_dqi  --root :version Width     100  
dvc_set_dqi  --root :version Height    150  
dvc_set_dqi  --root :version Area      15  
dvc_set_dqi  --root :version VCongest  0.01%
dvc_set_dqi  --root :version HCongest  0.02%
dvc_set_dqi  --root :version DRC   500
dvc_set_dqi  --root :version WNS  -100
dvc_set_dqi  --root :version TNS  -1000
dvc_set_dqi  --root :version NVP  1000
dvc_set_dqi  --root :version REG2REG/WNS  -100
dvc_set_dqi  --root :version REG2REG/TNS  -1000
dvc_set_dqi  --root :version REG2REG/NVP  1000
dvc_set_dqi  --root :version REG2MACRO/WNS  -100
dvc_set_dqi  --root :version REG2MACRO/TNS  -1000
dvc_set_dqi  --root :version REG2MACRO/NVP  1000
dvc_set_dqi  --root :version MACRO2REG/WNS  -100
dvc_set_dqi  --root :version MACRO2REG/TNS  -1000
dvc_set_dqi  --root :version MACRO2REG/NVP  1000
dvc_set_dqi  --root :version ICG_GEN/WNS  -100
dvc_set_dqi  --root :version ICG_GEN/TNS  -1000
dvc_set_dqi  --root :version ICG_GEN/NVP  1000
dvc_checkin_version

  set step_list = "preplace place cts route postroute"
  foreach step ($step_list) 
    dvc_create_container  $step
    dvc_checkout_container
    dvc_copy_object report/sta.rpt  sta.rpt
    dvc_copy_object report/apr.log  apr.log
    
    if {(test -e report/$step.jpg)} then
       dvc_copy_object report/$step.jpg
    endif 
    
    dvc_set_dqi  --root :container Runtime  `date +%S`
    dvc_set_dqi  --root :container WNS  -100
    dvc_set_dqi  --root :container TNS  -1000
    dvc_set_dqi  --root :container NVP  1000
    dvc_set_dqi  --root :container REG2REG/WNS  -100
    dvc_set_dqi  --root :container REG2REG/TNS  -1000
    dvc_set_dqi  --root :container REG2REG/NVP  1000
    dvc_set_dqi  --root :container REG2MACRO/WNS  -100
    dvc_set_dqi  --root :container REG2MACRO/TNS  -1000
    dvc_set_dqi  --root :container REG2MACRO/NVP  1000
    dvc_set_dqi  --root :container MACRO2REG/WNS  -100
    dvc_set_dqi  --root :container MACRO2REG/TNS  -1000
    dvc_set_dqi  --root :container MACRO2REG/NVP  1000
    dvc_set_dqi  --root :container ICG_GEN/WNS  -100
    dvc_set_dqi  --root :container ICG_GEN/TNS  -1000
    dvc_set_dqi  --root :container ICG_GEN/NVP  1000
    dvc_checkin_container
  end



