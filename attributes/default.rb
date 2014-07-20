default[:storm][:deploy][:user] = ::File.exists?("/home/vagrant") ? "vagrant" : "root"
default[:storm][:deploy][:group] = ::File.exists?("/home/vagrant") ? "vagrant" : "root"

default[:storm][:nimbus][:host] = "localhost"
default[:storm][:supervisor][:hosts] = [ "localhost" ]

default[:storm][:nimbus][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:supervisor][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"
default[:storm][:supervisor][:workerports] = (6700..6706).to_a
default[:storm][:worker][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:ui][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:storm][:version] = "0.9.1-incubating"

default[:storm][:path][:user] = "/#{node[:storm][:deploy][:user]}"
default[:storm][:path][:storm] = "#{default[:storm][:path][:user]}/apache-storm-#{node[:storm][:version]}"

