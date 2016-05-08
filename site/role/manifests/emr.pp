# Role for installing/configuring EMR OpenMRS
class role::emr {

  include 'profile::base'
  include 'profile::postgresql'

  class { 'profile::tomcat':
    require => Class['profile::base'],
  }

  class { 'profile::openmrs':
    require => [
      Class['profile::base'],
      Class['profile::tomcat'],
    ]
  }
}
