default[:deployment][:ubuntu_mirror] = "sg"
default[:deployment][:user] = ::File.exists?("/home/vagrant") ? "vagrant" : "ubuntu"
default[:deployment][:group] = ::File.exists?("/home/vagrant") ? "vagrant" : "ubuntu"
default[:stormproject][:nimbus][:host] = "192.168.42.10"
default[:stormproject][:supervisor][:hosts] = [ "192.168.42.20" ]

default[:stormproject][:nimbus][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:stormproject][:supervisor][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"
default[:stormproject][:supervisor][:workerports] = (6700..6706).to_a
default[:stormproject][:worker][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"

default[:stormproject][:ui][:childopts] = "-Xmx512m -Djava.net.preferIPv4Stack=true"
