#!/bin/csh -f

### 1. Setup svn file server and project account - CAD/IT

dvc_set_server SVN_ROOT $HOME/proj_svn
dvc_set_server SVN_MODE file

dvc_init_server start

### 2. Create project respository - Project Manager

dvc_create_project testcase

### 3. Create design version folder and checkin design data - Design Manager

#dvc_remove_design P1-trial/chip/000-DATA/2017_0910-xxx
dvc_create_design P1-trial/chip/000-DATA/2017_0910-xxx

dvc_checkout_design P1-trial/chip/000-DATA/2017_0910-xxx

cp design_x.v :version/design.v
cp design_x.sdc :version/design.sdc

dvc_checkin_design

dvc_list_project --recursive

tree :

