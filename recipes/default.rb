#
# Cookbook Name:: snmp-wrapper
# Recipe:: default
#
# Copyright 2014, Naoya Nakazawa
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'snmp'
include_recipe 'rsyslog'


file '/var/log/mail/statistics' do
  action :delete
end

if node['platform_family'] == 'rhel'
  snmpd_config = (node['platform_version'].to_i == 5) ? 'snmpd.options' : 'snmpd'
  template "/etc/sysconfig/#{snmpd_config}" do
    source 'snmpd-options.erb'
    mode 0775
    action :create
    notifies :restart, "service[#{node['snmp']['service']}]"
  end
end

begin
  r = resources('template[/etc/snmp/snmpd.conf]')
  r.cookbook 'snmp-wrapper'
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template /etc/snmp/snmpd.conf to override!"
end

template "#{node['rsyslog']['config_prefix']}/rsyslog.d/60-snmp.conf" do
  source 'rsyslog-60-snmp.conf.erb'
  notifies :restart, "service[#{node['rsyslog']['service_name']}]"
end
