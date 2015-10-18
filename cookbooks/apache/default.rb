package "httpd" do
  action :install
end

file "/etc/httpd/conf/httpd.conf" do
  action :edit
  block do |content|
    content.gsub!(/Listen\s+80/, "Listen 0.0.0.0:80\nListen ::1:80")
  end
end

service 'httpd' do
  action [:enable, :start]
end

file "/etc/sysconfig/iptables" do
  action :edit
  block do |content|
    content.gsub!(/-A\s+INPUT\s+-m\s+state\s+--state\s+NEW\s+-m\s+tcp\s+-p\s+tcp\s+--dport\s+22\s+-j\s+ACCEPT/, "-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT\n-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT")
  end
end

file "/etc/sysconfig/ip6tables" do
  action :edit
  block do |content|
    content.gsub!(/-A\s+INPUT\s+-m\s+state\s+--state\s+NEW\s+-m\s+tcp\s+-p\s+tcp\s+--dport\s+22\s+-j\s+ACCEPT/, "-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT\n-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT")
  end
end

service 'iptables' do
  action :restart
end

service 'ip6tables' do
  action :restart
end
