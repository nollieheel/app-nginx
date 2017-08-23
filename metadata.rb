name             'app-nginx'
maintainer       'Earth U'
maintainer_email 'iskitingbords @ gmail.com'
license          'Apache License'
description      'Just a wrapper for setting up Nginx webserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/nollieheel/app-nginx'
issues_url       'https://github.com/nollieheel/app-nginx/issues'
version          '0.1.0'

depends 'nginx', '~> 2.7.6'
depends 'openssl', '~> 4.4.0'

supports 'ubuntu', '14.04'
