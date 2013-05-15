include_recipe "storm"

template "Storm conf file" do
  path "/home/#{node[:deployment][:user]}/storm-0.8.2/conf/storm.yaml"
  source "ui.yaml.erb"
  owner node[:deployment][:user]
  group node[:deployment][:group]
  mode 0644
end

bash "Start ui" do
  user node[:deployment][:user]
  cwd "/home/#{node[:deployment][:user]}"
  code <<-EOH
  pid=$(pgrep -f backtype.storm.ui.core)
  if [ -z $pid ]; then
    nohup storm-0.8.2/bin/storm ui >>ui.log 2>&1 &
  fi
  EOH
end
