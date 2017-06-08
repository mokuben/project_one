# execute "Update yum Development Tools" do
  # command "yum -y groupupdate \"Development Tools\""
# end
execute "rpm -i http://rpms.remirepo.net/enterprise/remi-release-6.rpm" do
  not_if "rpm -q remi-release"
end

%w{php php-mbstring php-pdo php-mysqlnd php-xml php-devel php-pecl-xdebug}.each do |name|
  package name do
    action :install
    options '--enablerepo=remi-php56'
  end
end
template "/etc/php.ini" do
  source "php.ini.erb"
end

package "httpd" do
  action :install
end
template "/etc/httpd/conf/httpd.conf" do
  source "httpd.conf.erb"
end
service "httpd" do
  action [:start, :enable]
end

%w{mysql mysql-server}.each do |name|
  package name do
    action :install
  end
end
service "mysqld" do
  action [:start, :enable]
end

service "httpd" do
  action :restart
end