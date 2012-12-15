default[:deployment][:user] = "ubuntu"
default[:deployment][:group] = "ubuntu"
default[:stormproject][:nimbus] = "172.16.42.2"
default[:stormproject][:supervisors] = [ "172.16.42.5" ]

default[:stormproject][:supervisor][:childopts][:javaopts] = "-Xmx768m -Djava.net.preferIPv4Stack=true"
default[:stormproject][:supervisor][:workerports] = (6700..6706).to_a
