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
  set scenario_list = `dvc_list_version $version`
  foreach scenario ($scenario_list) 
    dvc_checkout_container $scenario
  end
end

dvc_list_project --recursive

tree :


