#
# Cookbook Name:: storm-project
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w[ curl unzip uuid-dev python-dev openjdk-7-jdk zookeeper ].each do |pkg|
    package pkg do
        action :install
    end
end

file "/etc/profile.d/javahome.sh" do
  owner "root"
  group "root"
  mode 00755
  action :create
  content <<-EOH
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
  EOH
end

bash "Setup zookeeper as a daemon" do
  code <<-EOH
  sudo ln -s /usr/share/zookeeper/bin/zkServer.sh /etc/init.d
  EOH
  not_if do
    ::File.exists?("/etc/init.d/zkServer.sh")
  end
end

bash "Install zeromq 2.1.7" do
  code <<-EOH
  cd /tmp
  curl -O http://download.zeromq.org/zeromq-2.1.7.tar.gz
  tar -xzvf zeromq-2.1.7.tar.gz
  cd zeromq-2.1.7
  ./configure
  make
  make install
  EOH
  not_if do
    ::File.exists?("/usr/local/lib/libzmq.so")
  end
end

bash "Install jzmq" do
  code <<-EOH
  export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
  cd /tmp
  rm -rf jzmq || true
git clone --depth 1 https://github.com/nathanmarz/jzmq.git
cd jzmq
./autogen.sh
./configure
touch src/classdist_noinst.stamp
cd src/
CLASSPATH=.:./.:$CLASSPATH javac -d . org/zeromq/ZMQ.java org/zeromq/App.java org/zeromq/ZMQForwarder.java org/zeromq/EmbeddedLibraryTools.java org/zeromq/ZMQQueue.java org/zeromq/ZMQStreamer.java org/zeromq/ZMQException.java
cd ..
make
sudo make install
  EOH
  not_if do
    ::File.exists?("/usr/local/lib/libjzmq.so")
  end
end

bash "Storm install" do
  user "ubuntu"
  code <<-EOH
  cd /home/ubuntu
  mkdir storm || true
  wget https://github.com/downloads/nathanmarz/storm/storm-0.8.1.zip
  unzip storm-0.8.1.zip
  cd storm-0.8.1
  EOH
  not_if do
    ::File.exists?("/home/ubuntu/storm-0.8.1")
  end
end


