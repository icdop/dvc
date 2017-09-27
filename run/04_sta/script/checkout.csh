#!/bin/csh -f

dvc_set_server SVN_ROOT $HOME/proj_svn

dvc_checkout_project testcase
dvc_checkout_phase   P1-trial
dvc_checkout_block   chip
dvc_checkout_stage   520-sta

set version_list = `dvc_list_stage 620-sta`
foreach version ($version_list)
  dvc_checkout_version $version
  set scenario_list = `dvc_list_version $version`
  foreach scenario ($scenario_list) 
    dvc_checkout_container $scenario
  end
end

dvc_tree_design


