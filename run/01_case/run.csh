#!/bin/csh -f

### 1. Setup svn file server and project account - CAD/IT

dvc_init_server --root svn_root --mode file

### 2. Create project respository - Project Manager

dvc_create_project testcase

### 3. Create design version folder and checkin design data - Design Manager
#dvc_checkout_project

dvc_create_folder chip/P1-trial/000-DATA/2017_0910-xxx

dvc_checkout_folder

cp design_x.v :version/design.v
cp design_x.sdc :version/design.sdc

dvc_checkin_folder

dvc_list_project --recursive

dvc_list_folder

