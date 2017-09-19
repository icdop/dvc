#!/bin/csh -f

### 1. Setup svn file server and project account - CAD/IT

dvc_set_server SVN_ROOT $HOME/proj_svn
dvc_set_server SVN_MODE file

dvc_init_server start

### 2. Create project respository - Project Manager

dvc_create_project testcase

### 3. Create design version folder and checkin design data - Design Manager

dvc_create_version P1-trial/chip/620-sta/2017_0910-xxx
dvc_create_version P1-trial/chip/620-sta/2017_0911-xxx
dvc_create_version P1-trial/chip/620-sta/2017_0912-xxx

dvc_checkout_project testcase
dvc_checkout_phase   P1-trial
dvc_checkout_block   chip
dvc_checkout_stage   620-sta

set version_list = `dvc_list_stage 620-sta`
foreach version ($version_list)
  dvc_checkout_version $version
  cp data/design.v   :version/design.v
  cp data/design.sdc :version/design.sdc
  dvc_set_dqi  --root :version WNS  -100
  dvc_set_dqi  --root :version NVP  1000
  dvc_set_dqi  --root :version DRC   500
  dvc_checkin_version
  set scenario_list = "001 002 003 004"
  foreach scenario ($scenario_list) 
    set wns=`date +%M`
    set nvp=`date +%S`
    dvc_create_container  $scenario
    dvc_checkout_container
    dvc_copy_object report/sta.rpt  sta.rpt
    dvc_copy_object report/sta.log  sta.log
    dvc_set_dqi  --root :container WNS  $wns
    dvc_set_dqi  --root :container NVP  $nvp
    dvc_checkin_container
  end
end

dvc_list_project --recursive

tree :


