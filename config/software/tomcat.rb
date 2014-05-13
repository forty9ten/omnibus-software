name "tomcat"
default_version "7.0.53"

dependency "rsync"
dependency "jre"

tomcat_archive = "apache-tomcat-#{default_version}.tar.gz"

source :url => "http://apache.mirrorcatalogs.com/tomcat/tomcat-7/v#{version}/bin/#{tomcat_archive}",
       :md5 => "7062e134b4390e2ce6b54081aab26e3c"

relative_path "apache-tomcat-#{default_version}"
tomcat_dir     = "#{install_dir}/embedded/tomcat7"
tomcat_log_dir = "#{tomcat_dir}/logs"

build do
  command "mkdir -p #{tomcat_dir}"
  command "mkdir -p #{tomcat_log_dir}"
  command "#{install_dir}/embedded/bin/rsync -a . #{tomcat_dir}"
end
