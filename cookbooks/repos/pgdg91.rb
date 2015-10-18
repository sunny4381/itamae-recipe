execute "pgdg91" do
  command "rpm -Uvh http://yum.pgrpms.org/9.1/redhat/rhel-6-x86_64/pgdg-centos91-9.1-4.noarch.rpm"
  not_if "test -f /etc/yum.repos.d/pgdg-91-centos.repo"
end
