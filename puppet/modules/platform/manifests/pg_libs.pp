class platform::pg_libs {
  package {
    'libpq-dev':
    ensure => installed;  
  }

  class { 'postgresql::client' : }
}
