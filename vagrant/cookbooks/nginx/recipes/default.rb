execute "rpm -i http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm" do
  not_if "rpm -q nginx-release-centos"
  notifies :run, "execute[nginx.repo is replaced with mainline]", :immediately
end

execute "nginx.repo is replaced with mainline" do
  command "sed -ri 's|/packages/centos/|/packages/mainline/centos/|' /etc/yum.repos.d/nginx.repo"
  action :nothing
end

yum_package "nginx" do
  options "--disablerepo=* --enablerepo=nginx"
  notifies :start, "service[nginx]", :delayed
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
end

template "/etc/nginx/conf.d/project.one.conf" do
  source "project.one.conf.erb"
end

service "nginx" do
  action [:enable]
end