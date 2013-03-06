class build::deb_support() {

package {
  'libcurl4-openssl-dev':
    ensure => 'installed';
}

package{
  'xvfb' :
  ensure => latest;
  'tig' :
  ensure => latest;
}

package{'libqtwebkit-dev':
  ensure => installed
}

# packages required for passenger
package {
  'devscripts' :
  ensure => 'latest';
  'apache2-threaded-dev':
  ensure => 'latest';
  'apache2-mpm-worker':
  ensure => 'latest';
  'libapr1-dev':
  ensure => 'latest';
  'debhelper':
  ensure => 'latest';
  'rake':
  ensure => 'latest';
  'cdbs':
  ensure => 'latest';
  'libev-dev':
  ensure => 'latest';
  'libgoogle-perftools-dev':
  ensure => 'latest';
}

# further packages required for nginx
package{
  'libgd2-noxpm' :
  ensure => 'latest';
  'libgd2-noxpm-dev' :
  ensure => 'latest';
  'libgeoip-dev'  :
  ensure => 'latest';
  'liblua5.1-dev':
  ensure => 'latest';
  'libmhash-dev':
  ensure => 'latest';
  'libpam0g-dev':
  ensure => 'latest';
  'libperl-dev':
  ensure => 'latest';
}

}
