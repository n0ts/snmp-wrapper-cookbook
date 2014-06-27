#
# Cookbook Name:: snmp-wrapper
# Attribute:: default
#
# Copyright 2014, Naoya Nakazawa
#
# All rights reserved - Do Not Redistribute
#

include_attribute 'snmp::default'
include_attribute 'rsyslog::default'


default['snmp-wrapper'] = {
  'log_facility' => 6,
}

