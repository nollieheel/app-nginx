name             'app-nginx'
maintainer       'Earth U'
maintainer_email 'iskitingbords @ gmail.com'
license          'Apache License'
description      'Just a wrapper for setting up Nginx webserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/nollieheel/app-nginx'
issues_url       'https://github.com/nollieheel/app-nginx/issues'
version          '1.0.0'

depends 'nginx', '~> 8.0.0'
depends 'openssl', '~> 8.1.2'

supports 'ubuntu', '14.04'
