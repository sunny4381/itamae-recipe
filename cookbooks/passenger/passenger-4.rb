package "libcurl-devel"
package "httpd-devel"

execute "install passenger gem" do
  user "vagrant"
  command "source /etc/profile.d/rvm.sh && rvmsudo gem install passenger -v 4.0.59"
  not_if "source /etc/profile.d/rvm.sh; which passenger"
end

execute "install passenger httpd module" do
  user "vagrant"
  command "source /etc/profile.d/rvm.sh && rvmsudo passenger-install-apache2-module --auto"
  not_if "source /etc/profile.d/rvm.sh; test $(find $GEM_HOME -name mod_passenger.so | wc -l) != '0'"
end

execute "create passnger.conf" do
  user "vagrant"
  command "(source /etc/profile.d/rvm.sh && passenger-install-apache2-module --snippet) | sudo tee /etc/httpd/conf.d/passnger.conf"
  not_if "test -f /etc/httpd/conf.d/passnger.conf"
end
