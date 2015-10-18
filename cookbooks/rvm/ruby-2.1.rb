execute "import gpg key" do
  command "gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 || gpg2 --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
end

execute "install rvm and ruby 2.1.5" do
  command "curl -sSL https://get.rvm.io | bash -s stable --ruby=2.1.5"
  not_if "test -f /usr/local/rvm/scripts/rvm"
end

file "/home/vagrant/.gemrc" do
  owner "vagrant"
  group "vagrant"
  content "install: --no-document\nupdate: --no-document\n"
end

file "/root/.gemrc" do
  content "install: --no-document\nupdate: --no-document\n"
end

file "/etc/profile.d/rvmsudo_secure_path.sh" do
  content "export rvmsudo_secure_path=0\n"
end

file "/etc/sudoers" do
  action :edit
  block do |content|
    content.gsub!(/\(Defaults[\t ][\t ]*secure_path\)/, '# \1')
  end
end

execute "install bundler" do
  user "vagrant"
  command "source /etc/profile.d/rvm.sh; rvmsudo gem install bundler"
end
