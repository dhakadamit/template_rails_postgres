define vagrant::rails_project($name, $env="development", $port) {

  include postgresql::server

  postgresql::db_instance{
    "${name}-dev" :
      databasename => "${name}_development",
      rolename => 'developer',
      password => 'password',
      require => Class['postgresql::server']
  }

  postgresql::db_instance{
    "${name}-test" :
      databasename => "${name}_test",
      rolename => 'developer',
      password => 'password',
      require => Class['postgresql::server']
  }

  class { "web::${name}" :
    service_address => "${name}.sportech.tld",
    service_port => "${port}",
    rails_env => "${env}",
    require => Class['web::service_collection'];
  }

  file { "/opt/sportech.tld/${name}/current":
      ensure => link,
      target => "/home/vagrant/${name}",
      owner => "${name}",
      group => "${name}";
    }

}