package "epel-release"

file "/etc/yum.repos.d/epel.repo" do
  action :edit
  block do |content|
    content.gsub!("enabled=1", "enabled=0")
  end
end
