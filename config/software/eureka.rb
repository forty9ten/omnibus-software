name "eureka"
default_version "1.1.132"

dependency "tomcat"
dependency "jre"

eureka_server_war = "eureka-server-#{default_version}.war"

source :url => "http://repo1.maven.org/maven2/com/netflix/eureka/eureka-server/#{default_version}/eureka-server-#{default_version}.war",
       :md5 => "1daeb691460ddd2c41bd2d82b008a577"

tomcat7_webapp_dir = "#{install_dir}/embedded/tomcat7/webapps"

relative_path = "eureka"

build do
  command "unzip #{project_dir}/#{eureka_server_war} -d eureka"
  command "cp -rf #{project_dir}/eureka #{tomcat7_webapp_dir}/eureka"
  command "rm -rf #{tomcat7_webapp_dir}/eureka/WEB-INF/classes/eureka-*.properties"

  # default client properties
  command "cat << EOF > #{tomcat7_webapp_dir}/eureka/WEB-INF/classes/eureka-client.properties
eureka.region=default
eureka.name=eureka
eureka.vipAddress=eureka.mydomain.net
eureka.port=8080
eureka.preferSameZone=false
eureka.shouldUseDns=false

eureka.serviceUrl.defaultZone=http://localhost:8080/eureka/v2/
eureka.serviceUrl.default.defaultZone=http://localhost:8080/eureka/v2/
EOF"

  # default server properties
  command "cat << EOF > #{tomcat7_webapp_dir}/eureka/WEB-INF/classes/eureka-server.properties
eureka.waitTimeInMsWhenSyncEmpty=0
EOF"

  # basic run script
  command "cat << EOF > #{install_dir}/embedded/bin/run_eureka.sh
export JAVA_OPTS=\"${JAVA_OPTS} \
-Deureka.enableSelfPreservation=false \
-Deureka.environment=prod \
-Xms512m \
-Xmx1024m\"

JAVA_HOME=\"#{install_dir}/embedded/jre\" #{install_dir}/embedded/tomcat7/bin/startup.sh
EOF"

  command "chmod +x #{install_dir}/embedded/bin/run_eureka.sh"

end
