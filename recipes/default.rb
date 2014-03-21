package "python"
package "python-setuptools"
package "python-distutils-extra"

remote_file "/tmp/s3cmd.master.tar.gz" do
    source node["s3cmd"]["download_url"]
    mode "0644"
end

package "python-dateutil" do
    action :install
end



execute "untar_s3cmd" do
    cwd "/tmp"
    command "tar xzvf s3cmd.master.tar.gz"
    action :run
end

execute "install_s3cmd" do
    cwd "/tmp/s3cmd-master"
    command "python setup.py install"
    action :run
end

template "/tmp/s3cfg" do
  source "s3cfg.erb"
  owner "root"
  group "root"
  mode "0644"
end
