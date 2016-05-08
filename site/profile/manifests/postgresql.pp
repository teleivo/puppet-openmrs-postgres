# Role for installing/configuring DB PostgreSQL
class profile::postgresql {

  include ::postgresql::globals
  include ::postgresql::server
  include ::postgresql::lib::java

  ::postgresql::server::extension { 'fuzzystrmatch':
    ensure         => present,
    database       => 'openmrs',
    package_name   => 'postgresql-contrib',
    package_ensure => 'present',
  }

  Class['::postgresql::globals']->
  Class['::postgresql::server']
}
