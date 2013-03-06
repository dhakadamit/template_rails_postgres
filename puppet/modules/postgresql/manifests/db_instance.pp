define postgresql::db_instance( $databasename , $rolename , $password, $elevate = false)
{
  postgresql::role { 
    "${databasename}-${rolename}" :
      rolename => "$rolename",
      ensure => present,
      password => "$password",
      elevate => $elevate,
      require => Service['postgresql'],
  }

  postgresql::database { $databasename :
      ensure => present,
      owner => "$rolename",
      require => Postgresql::Role["${databasename}-${rolename}"],
    }
}
