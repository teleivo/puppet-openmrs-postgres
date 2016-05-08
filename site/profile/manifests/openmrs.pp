# Profile for installing/configuring OpenMRS
class profile::openmrs {

  ::postgresql::server::role { 'openmrs':
    password_hash   => postgresql_password('openmrs', 'openmrs'),
    createdb        => true,
    superuser       => true,
    before          => Postgresql::Server::Database['openmrs'],
  }

  ::postgresql::server::pg_hba_rule { 'allow openmrs access to all databases':
    description => 'Open up postgresql for access by openmrs from localhost',
    type        => 'host',
    database    => 'all',
    user        => 'openmrs',
    address     => '127.0.0.1/32',
    auth_method => 'md5',
  }

  ::postgresql::server::db { 'openmrs':
    owner     => 'openmrs',
    user      => 'openmrs',
    password  => postgresql_password('openmrs', 'openmrs'),
    grant     => 'ALL',
  }

  $tomcat_user = hiera('openmrs::tomcat_user')
  $tomcat_catalina_base = hiera('openmrs::tomcat_catalina_base')
  $openmrs_application_data_directory =
  hiera('openmrs::openmrs_application_data_directory')
  file { $openmrs_application_data_directory:
    ensure => directory,
    owner  => $tomcat_user,
    group  => $tomcat_user,
    mode   => '0755',
  }
}
