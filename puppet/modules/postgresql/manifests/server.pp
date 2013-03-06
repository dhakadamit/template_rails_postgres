class postgresql::server(
  $version="9.1",
  $environment="default",
  $server_type="standalone",
  $data_directory="/var/lib/postgresql/9.1/main/",
  $log_directory="/var/lib/postgresql/9.1/pg_log/",
  $max_connections=100,
  $wal_keep_segments = 32,
  $archive_mode = off,
  $archive_timeout = 0,
  $max_wal_senders = 0,
  $checkpoint_segments = 3,
  $listen_addresses= '*',
  $shared_buffers = '24MB',
  $wal_level = 'minimal',
  $port = 5432,
)
{




  package {
     "postgresql" :
       ensure => installed;
     "postgresql-common" :
     ensure => installed;
       "postgresql-contrib-9.1" :
       ensure => installed;
  }

  File {
      owner => "postgres",
      group => "postgres",
  }

  file { 'postgres_data_dir':
        path => "$data_directory",
        ensure => directory,
        recurse => true,
        mode   => '0600',
        require => Package['postgresql'];
        }


  file { 'postgres_log_dir':
        path => "$log_directory",
        ensure => directory,
        recurse => true,
        mode => '0600',
        require => Package['postgresql'];
        }

  $create_cluster_command = "pg_dropcluster --stop ${version} main; pg_createcluster --start --locale en_UK.utf8 -e UTF8 ${version} main --datadir ${data_directory}"

  exec { 'recreate_utf8_cluster' :
    command => $create_cluster_command,
    unless => "pg_lsclusters -h | awk '{ print \$6; }' | egrep `(echo $data_directory | sed '\$s/.\$//')`",
    path => ['/usr/bin','/bin'],
    require => [Package['postgresql'], File['pg_hba.conf' , 'postgresql.conf']],
  }

  file { "pg_hba.conf":
      path => "/etc/postgresql/${version}/main/pg_hba.conf",
      source => "puppet:///modules/postgresql/${environment}/pg_hba.conf",
      #require => Exec['recreate_utf8_cluster'];
      require => Package['postgresql'];
  }

  file { "postgresql.conf":
      path => "/etc/postgresql/${version}/main/postgresql.conf",
      content => template("postgresql/${server_type}_postgresql.conf.erb"),
      #require => Exec['recreate_utf8_cluster'];
      require => Package['postgresql'];
  }

  service { "postgresql":
      ensure => running,
      enable => true,
      hasstatus => true,
      hasrestart => true,
      subscribe => [Package["postgresql"],
                  File["pg_hba.conf"],
                  File["postgresql.conf"]],
  }

}


