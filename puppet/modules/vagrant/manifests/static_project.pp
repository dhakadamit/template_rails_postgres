define vagrant::static_project($name, $port) {

  class { "web::${name}" :
    service_address => "${name}.sportech.tld",
    service_port => "${port}",
    require => Class['web::service_collection'];
  }

  file { "/opt/sportech.tld/${name}/current":
      ensure => link,
      target => "/home/vagrant/${name}",
      owner => "${name}",
      group => "${name}";
    }

}