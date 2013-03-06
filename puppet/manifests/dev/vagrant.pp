class { 'platform' : }

Exec {
path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin"
}

class { 'vagrant' : }

include postgresql::server

postgresql::db_instance{
  "thetribe-dev" :
  databasename => "thetribe_development",
  rolename => 'developer',
  password => 'password',
  require => Class['postgresql::server']
}

postgresql::db_instance{
  "thetribe-test" :
  databasename => "thetribe_test",
  rolename => 'developer',
  password => 'password',
  require => Class['postgresql::server']
}