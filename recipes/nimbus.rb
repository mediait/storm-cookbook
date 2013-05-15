include_recipe "storm"

template "Storm conf file" do
  path "/home/#{node[:storm][:deploy][:user]}/storm-0.8.2/conf/storm.yaml"
  source "nimbus.yaml.erb"
  owner node[:storm][:deploy][:user]
  group node[:storm][:deploy][:group]
  mode 0644
end

bash "Start nimbus" do
  user node[:storm][:deploy][:user]
  cwd "/home/#{node[:storm][:deploy][:user]}"
  code <<-EOH
  pid=$(pgrep -f backtype.storm.daemon.nimbus)
  if [ -z $pid ]; then
    nohup storm-0.8.2/bin/storm nimbus >>nimbus.log 2>&1 &  
  fi
  EOH
end
