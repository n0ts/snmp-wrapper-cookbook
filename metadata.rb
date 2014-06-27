name             'snmp-wrapper'
maintainer       'Naoya Nakazawa'
maintainer_email 'me@n0ts.org'
license          'All rights reserved'
description      'Installs/Configures snmp-wrapper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ rsyslog snmp }.each do |depend|
  depends depend
end

