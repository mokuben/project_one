bash "copy" do
  user "root" 
  code <<-EOH
    cp /etc/localtime /etc/localtime.org
    cp /etc/my.cnf /etc/my.cnf.org
    ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
    cd /vagrant
    php composer.phar self-update
    php composer.phar update
    php oil refine install
    cp fuel/core/bootstrap_phpunit.php fuel/app/bootstrap_phpunit.php
    cp fuel/core/phpunit.xml fuel/app/phpunit.xml
  EOH
end

template "/etc/my.cnf.org" do
  source "my.cnf.erb"
end

template "/etc/sysconfig/clock" do
  source "clock.erb"
end

template "/vagrant/fuel/app/phpunit.xml" do
  source "phpunit.xml.erb"
end

service "httpd" do
  action :restart
end

service "mysqld" do
  action :restart
end
