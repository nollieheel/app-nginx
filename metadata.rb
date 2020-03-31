name             'app-nginx'
maintainer       'Earth U'
maintainer_email 'iskitingbords@gmail.com'
license          'Apache License'
description      'Just a wrapper for setting up Nginx webserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/nollieheel/app-nginx'
issues_url       'https://github.com/nollieheel/app-nginx/issues'
version          '2.0.1'

depends 'nginx', '~> 9.0'
depends 'openssl', '~> 8.5'

supports 'ubuntu', '14.04'
supports 'ubuntu', '16.04'
