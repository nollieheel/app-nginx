name             'app_nginx'
maintainer       'Earth U'
maintainer_email 'iskitingbords@gmail.com'
license          'Apache-2.0'
description      'Just a wrapper for setting up Nginx webserver'
source_url       'https://github.com/nollieheel/app-nginx'
issues_url       'https://github.com/nollieheel/app-nginx/issues'
version          '3.2.0'

depends 'nginx', '~> 12.1.0'

chef_version '>= 16.0'
supports     'ubuntu', '20.04'
