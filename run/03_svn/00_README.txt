# ========================================================
# DVC SVN Server Mode Example:
# ========================================================

  % make help

#---------------------------------------------------
# 0. Init SVN project repository
#---------------------------------------------------

  % make init    ; Start SVN server

#---------------------------------------------------
# 1. Create project directory in SVN server
#---------------------------------------------------

  % make project

#---------------------------------------------------
# 2. Create and Checkout version to local directory
#---------------------------------------------------

  % make version    ; create and checkout

  % make checkout   ; only checkout

#---------------------------------------------------
# 3. Create container
#---------------------------------------------------

  % make container

#---------------------------------------------------
# 4. copy files into container and tag for checkin
#---------------------------------------------------

  % make object    ;

#---------------------------------------------------
# 5. Commit change and checkin files to server
#---------------------------------------------------

  % make commit    ; only commit files been tagged
    or
  % make checkin   ; checkin all files in container  

#---------------------------------------------------
# 6. List files in direcotry
#---------------------------------------------------

  % make tree   ; local checkout directory

  % make list   ; file checked into server

#---------------------------------------------------
# 7. Clean up all release files of this testcase
#---------------------------------------------------

  % make clean


