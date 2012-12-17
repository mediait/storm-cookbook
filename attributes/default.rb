default[:deployment][:user] = ::File.exists?("/home/vagrant") ? "vagrant" : "ubuntu"
default[:deployment][:group] = ::File.exists?("/home/vagrant") ? "vagrant" : "ubuntu"
default[:stormproject][:nimbus] = "192.168.42.10"
default[:stormproject][:supervisors] = [ "192.168.42.20" ]

default[:stormproject][:supervisor][:childopts][:javaopts] = "-Xmx768m -Djava.net.preferIPv4Stack=true"
default[:stormproject][:supervisor][:workerports] = (6700..6706).to_a
