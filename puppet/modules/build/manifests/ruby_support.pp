class build::ruby_support() {
package {
  "libxml2-dev" :
    ensure => latest;
  "libxslt-dev" :
    ensure => latest;
}
  package {
    "ruby1.9.1-dev":
      ensure => latest;
    "libsqlite3-dev" :
      ensure => latest;
  }
}
