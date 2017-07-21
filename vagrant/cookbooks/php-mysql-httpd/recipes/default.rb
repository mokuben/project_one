# execute "Update yum Development Tools" do
  # command "yum -y groupupdate \"Development Tools\""
# end
execute "rpm -i http://rpms.remirepo.net/enterprise/remi-release-6.rpm" do
  not_if "rpm -q remi-release"
end

%w{php php-mbstring php-pdo php-mysqlnd php-xml php-devel php-pecl-xdebug}.each do |name|
  package name do
    action :install
    options '--enablerepo=remi-php71'
  end
end

template "/etc/php.d/xdebug.ini" do
  source "xdebug.ini.erb"
  owner 'root'
  group 'root'
  mode 0644
end

template "/etc/php.ini" do
  source "php.ini.erb"
end

package 'php-fpm' do
  options '--enablerepo=remi-php71'
  notifies :run, 'execute[php-fpm.conf tuning]', :immediately
end

# process_control_timeoutを60に設定
# コネクションタイムアウトと揃えないとreloadでも強制切断が発生するため
execute "php-fpm.conf tuning" do
  command "sed -ri.org -e 's|^;process_control_timeout.*|process_control_timeout = 60|' /etc/php-fpm.conf"
  action :nothing
  not_if 'test -f /etc/php-fpm.conf.org'
end

# www.confテンプレート
# TCPからUNIXソケットへ
# pm.max_children, max_requests, max_spare_serversほかチューニング
# max_processesの最大値はAMI作成時のメモリをベースに算出するので、packer実行インスタンスをあわせておく
template "/etc/php-fpm.d/www.conf" do
  source "www.conf.erb"
  variables(
    :socket => '/var/run/php-fpm/php-fpm.sock',
    :user => 'nginx',
    :max_processes => (("#{node[:memory][:total]}"[/\d+/].to_f * 0.8) / 20).to_i # max number of php-fpm processes; 80% of total memory, php-fpm uses 20MB each
  )
end

#package "httpd" do
  #action :install
#end
#template "/etc/httpd/conf/httpd.conf" do
  #source "httpd.conf.erb"
#end
#service "httpd" do
  #action [:start, :enable]
#end

%w{mysql mysql-server}.each do |name|
  package name do
    action :install
  end
end
service "mysqld" do
  action [:start, :enable]
end

service "php-fpm" do
  action [:start, :enable]
end

service "nginx" do
  action [:restart, :enable]
end

#service "httpd" do
  #action :restart
#end