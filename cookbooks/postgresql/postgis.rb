package "postgresql91-server"
package "postgresql91-devel"
package "postgis2_91" do
  options "--enablerepo=epel"
end

execute "initialize database" do
  command "/etc/init.d/postgresql-9.1 initdb"
  not_if "test -f /var/lib/pgsql/9.1/data/postgresql.conf"
end

file "/var/lib/pgsql/9.1/data/pg_hba.conf" do
  action :edit
  block do |content|
    # content.gsub!('ident', 'md5')
    content.gsub!(/(127\.0\.0\.1\/.*)ident/, '\1md5')
    content.gsub!(/(::1\/.*)ident/, '\1md5')
  end
end

service 'postgresql-9.1' do
  action [:enable, :start]
end

execute "wait for starting postgresql" do
  command "sleep 10s"
end

execute "set password" do
  user "postgres"
  command "psql -c \"alter user postgres with password 'postgres'\""
end
