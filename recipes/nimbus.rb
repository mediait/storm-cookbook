template "Storm conf file" do
  path "/home/ubuntu/storm-0.8.1/conf/storm.yaml"
  source "nimbus.yaml.erb"
  owner node[:deployment][:user]
  group node[:deployment][:group]
  mode 0644
end

