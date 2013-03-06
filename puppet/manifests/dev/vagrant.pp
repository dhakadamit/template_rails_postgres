class { 'platform' : }

Exec {
path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin"
}

class { 'vagrant' : }

exec { 'heroku toolbelt' :
command => 'wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh' }

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