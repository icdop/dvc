# Database Version Control Engine -- Subversion

- The SVN server is initialized withthe following parameters:

	  $SVN_ROOT : svn repository root path, need to be set first
	
	  $SVN_MODE : svn | file -- server db access mode
	  $SVN_HOST : server host name -- only been used in svn server mode
	  $SVN_PORT : server port name -- only been used in svn server mode

- When a project is created, there will be one repository under:

	  $SVN_ROOT/<project_name>/

- Project config files are copied from $DVC_HOME/etc/conf/:

	  $SVN_ROOT/<project_name>/conf/
      

## 1. create SVN design repository:

	1-1. create SVN data root directory
		% mkdir /var/svn/project
		% chmod g+rwx /var/svn/project

	1.2. setup SVN server
		% svnserv -d -r /var/svn/project --listen-port=2390

		edit server config file, you can copy it from
		$DOP_HOME/dvc/etc/svn/* to conf/

	2-2. create repository for each project
		% dvc_set_svn /var/svn/project svn://localhost:3290/project
		% dvc_create_project testcase
		# svnadmin create /var/svn/project/testcase
		# setenv PROJT_URL http://localhost/project
		# svn auth  $PROJT_URL --username pm --password pm
		# svn mkdir $PROJT_URL/testcase -m "Init project" 

## 2. access design repository:

	2-1. file mode:
		SVN_URL = file://var/svn/project

		% setenv PROJT_URL $SVN_URL/testcase
		% svn list  $PROJT_URL/$$
		$ svn mkdir $PROJT_URL/$$
		% svn add $PROJT_URL/$$ <file>

	2-2. svn server mode
		SVN_URL = svn://localhost

		% setenv PROJT_URL $SVN_URL/testcase
		% svn list $PROJT_URL/$$
		% svn add $PROJT_URL/$$ <file>


	3-3. http server mode:
		apache2 -d
		SVN_URL = http://localhost/project

		% setenv PROJT_URL $SVN_URL/testcase
		% svn list $PROJT_URL/$$
		% svn add $PROJT_URL/$$ <file>

## 3. setup apache server for SVN:

	1-1. find mod_dav_svn rpm and install it
		% sudo apt-get install mod_dav_svn
		% a2enmod dav_svn
		% sudo apt-get install mod_authz_user
		% a2enmod authz_user

	1-2. modify apache server config file
		httpd.conf     in /etc/httpd/conf/httpd.conf
		apache2.conf   in /etc/apache2/apache2.conf
		Add the following line
		-----
		LoadModule mod_dav_svn modules/mod_dav_svn.so

		<Location /project>
		  DAV svn
		  SVNParentPath /var/svn/project
		  AuthType Basic
		  AuthName "Subversion Repository"
		  AuthUserFile /etc/apache2/dav_svn.passwd
		  <LimitExcept GET PROPFIND OPTIONS REPORT>
		    Require valid-user
		  </LimitExcept> 
		</Location>
		----

	1-3. edit password file dav_svn.passwd
		pm:dvc
		db:dvc

	1-4. restart apache server
		% /etc/init/apache2 restart

