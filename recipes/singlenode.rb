include_recipe "storm"

template "Storm conf file" do
  path "/#{node[:storm][:deploy][:user]}/apache-storm-#{node[:storm][:version]}/conf/storm.yaml"
  source "singlenode.yaml.erb"
  owner node[:storm][:deploy][:user]
  group node[:storm][:deploy][:group]
  mode 0644
end

# Update netty to 3.9.2
remote_file "/#{node[:storm][:deploy][:user]}/apache-storm-#{node[:storm][:version]}/lib/netty-3.9.2.Final.jar" do
  source "http://central.maven.org/maven2/io/netty/netty/3.9.2.Final/netty-3.9.2.Final.jar"
  action :create_if_missing
end

file "/#{node[:storm][:deploy][:user]}/apache-storm-#{node[:storm][:version]}/lib/netty-3.6.3.Final.jar" do
  action :delete
end

bash "Start nimbus" do
  user node[:storm][:deploy][:user]
  cwd "/#{node[:storm][:deploy][:user]}"
  code <<-EOH
  pid=$(pgrep -f backtype.storm.daemon.nimbus)
  if [ -z $pid ]; then
    nohup apache-storm-#{node[:storm][:version]}/bin/storm nimbus >>nimbus.log 2>&1 &
  fi
  EOH
end

bash "Start supervisor" do
  user node[:storm][:deploy][:user]
  cwd "/#{node[:storm][:deploy][:user]}"
  code <<-EOH
  pid=$(pgrep -f backtype.storm.daemon.supervisor)
  if [ -z $pid ]; then
    nohup apache-storm-#{node[:storm][:version]}/bin/storm supervisor >>supervisor.log 2>&1 &
  fi
  EOH
end

bash "Start DRPC" do
  user node[:storm][:deploy][:user]
  cwd "/#{node[:storm][:deploy][:user]}"
  code <<-EOH
  pid=$(pgrep -f backtype.storm.daemon.drpc)
  if [ -z $pid ]; then
    nohup apache-storm-#{node[:storm][:version]}/bin/storm drpc >>drpc.log 2>&1 &
  fi
  EOH
end

bash "Start ui" do
  user node[:storm][:deploy][:user]
  cwd "/#{node[:storm][:deploy][:user]}"
  code <<-EOH
  pid=$(pgrep -f backtype.storm.ui.core)
  if [ -z $pid ]; then
    nohup apache-storm-#{node[:storm][:version]}/bin/storm ui >>ui.log 2>&1 &
  fi
  EOH
end
