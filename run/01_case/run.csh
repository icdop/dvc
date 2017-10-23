#!/bin/csh -f

### 1. Setup svn file server and project account - CAD/IT

dvc_init_server file

### 2. Create project respository - Project Manager

dvc_create_project --force 01_case

### 3. Create design version folder and checkin design data - Design Manager
dvc_checkout_project --force 01_case

dvc_create_design --force P1-trial/chip/000-DATA/2017_0910-xxx

dvc_checkout_design --force P1-trial/chip/000-DATA/2017_0910-xxx

cp design_x.v :version/design.v
cp design_x.sdc :version/design.sdc

dvc_checkin_design

dvc_list_project --recursive

dvc_list_design


