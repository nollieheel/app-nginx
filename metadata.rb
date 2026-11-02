name             'app_nginx'
maintainer       'Earth U'
maintainer_email 'iskitingbords@gmail.com'
license          'Apache-2.0'
description      'Wrapper for setting up Nginx webserver'
source_url       'https://github.com/nollieheel/app-nginx'
issues_url       'https://github.com/nollieheel/app-nginx/issues'
version          '6.0.0'

depends 'nginx', '12.3.0'

chef_version '18.5.0'
supports     'ubuntu', '24.04'
supports     'ubuntu', '26.04'
