Exec {
    path => [ '/usr/bin', '/bin', '/usr/sbin', '/sbin' ]
}

package { [ 'unzip', 'curl', 'maven' ]: }

class { 'postgresql::server': }

postgresql::server::role { "openmrs":
    password_hash   => postgresql_password('openmrs', 'openmrs'),
    createdb        => true,
    superuser       => true,
}

postgresql::server::db { 'openmrs':
    user     => 'openmrs',
    password => 'openmrs',
}

postgresql::server::pg_hba_rule { 'allow openmrs role access to all databases':
    description => "Open up postgresql for access by openmrs from localhost",
    type        => 'host',
    database    => 'all',
    user        => 'openmrs',
    address     => '127.0.0.1/32',
    auth_method => 'md5',
}

postgresql::server::extension { 'fuzzystrmatch':
    database       => 'openmrs',
    ensure         => 'present',
    package_name   => 'postgresql-contrib',
    package_ensure => 'present',
}

class { 'tomcat6':
    tomcat_users => [
                        {   name     => 'admin',
                            password => 'admin',
                            roles    => 'tomcat,admin,manager,manager-gui'
                        },
                    ],
    require => [ Package['unzip'], Package['curl'] ],
}
