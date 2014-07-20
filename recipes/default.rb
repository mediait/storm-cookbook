#
# Cookbook Name:: storm-project
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user_path = node[:storm][:path][:user]
storm_path = node[:storm][:path][:storm]

%w[ curl unzip build-essential pkg-config libtool autoconf git-core uuid-dev python-dev zookeeper ].each do |pkg|
  package pkg do
    retries 2
    action :install
  end
end

bash "Storm install" do
  user node[:storm][:deploy][:user]
  cwd user_path
  code <<-EOH
    mkdir storm-data || true
    wget http://apache.mirror.iweb.ca/incubator/storm/apache-storm-#{node[:storm][:version]}/apache-storm-#{node[:storm][:version]}.zip
    unzip apache-storm-#{node[:storm][:version]}.zip
    cd #{storm_path}
    rm -f /opt/storm
    ln -s #{storm_path} /opt/storm
  EOH
  not_if do
    ::File.exists?(storm_path)
  end
end