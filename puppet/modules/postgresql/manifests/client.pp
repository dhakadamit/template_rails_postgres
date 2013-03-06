class postgresql::client($version="9.1")
{
  package {
     "postgresql-client-${version}" :
        ensure => 'present'
  }
}

