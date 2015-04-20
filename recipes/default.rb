#
# Cookbook Name:: cog_c7common
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
package ['lsof','strace','sysstat','curl','wget','openssh-clients','gcc','make','man','psmisc','ntp','bzip2','iotop','libselinux-python','policycoreutils-python','git','yum-utils'] do
	action	:install
end

timezone = node['cog_c7common']['timezone']

execute "set timezone" do
	command "timedatectl set-timezone #{timezone}"
	action :run
end

servername = node['cog_c7common']['servername']

execute "set timezone" do
	command "hostnamectl set-hostname #{servername}"
	action :run
	only_if { node['cog_c7common']['servername'] && node['cog_c7common']['servername'] != node['machinename'] }
end

template "/root/.bashrc" do
	source "root_bashrc.erb"
	mode 0644
	owner "root"
	group "root"
	action :create
	only_if { node['cog_c7common']['shortname']}
end

template "/etc/motd" do
	source "motd.erb"
	mode 0644
	owner "root"
	group "root"
	action :create
	only_if { node['cog_c7common']['motd']}
end
