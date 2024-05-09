name             'app_nginx'
maintainer       'Earth U'
maintainer_email 'iskitingbords@gmail.com'
license          'Apache-2.0'
description      'Just a wrapper for setting up Nginx webserver'
source_url       'https://github.com/nollieheel/app-nginx'
issues_url       'https://github.com/nollieheel/app-nginx/issues'
version          '5.0.0'

depends 'app_add_apt', '~> 1.0.0'
depends 'nginx', '~> 12.2.9'

chef_version '>= 18.3'
supports     'ubuntu', '>= 22.04'
