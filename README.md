# puppet-openmrs-postgres

Quick vagrant/puppet setup to create a VM for testing/adapting OpenMRS to work with PostgreSQL

##Setup

###Setup requirements

To get started you need to install:
* [virtualbox](https://www.virtualbox.org/)
* [vagrant](https://www.vagrantup.com/downloads.html)

##How to get started

###Setup the VM
To setup a virtual machine execute:
```
git clone https://github.com/teleivo/puppet-openmrs-postgres.git
cd puppet-openmrs-postgres
vagrant up
```

This will download a virtualbox VM with Ubuntu 14.04 64bit, install all
necessary puppet modules via librarian-puppet and run the manifest/site.pp
which
* installs openjdk7
* installs maven
* installs PostgreSQL server (currently 9.3.8, depends on default in
  puppetlabs-postgresql module)
* creates PostgreSQL user 'openmrs' with password 'openmrs' and an empty
  database 'openmrs'
* installs tomcat 6.0.29
* creates tomcat user with the manager role. user 'admin' with password 'admin'

###Add PostgreSQL jdbc driver to tomcat
```
vagrant ssh
sudo su - tomcat6
cd apache-tomcat-6.0.29/lib
wget https://jdbc.postgresql.org/download/postgresql-9.3-1103.jdbc41.jar
```

###Deploy OpenMRS
Once vagrant is done with the installation and you added the jdbc driver to
tomcat you are ready to deploy OpenMRS into tomcat
* Get the version you want to try from [OpenMRS] (http://openmrs.org/)
* Deploy the war file in [localhost:8080/manager/](http://localhost:8080/manager/)
  * In the OpenMRS wizard, select 'Advanced' and enter the following into 'Database
connection':
```
jdbc:postgresql://localhost:5432/@DBNAME@
```
* Follow the wizard, enter the db 'openmrs' and db user 'openmrs' with password 'openmrs' where asked

##Access
###PostgreSQL DB
```
vagrant ssh
psql -U openmrs -h localhost -d openmrs
```

Password: openmrs

###Tomcat Manager
http://localhost:8080/manager/

User: admin
Password: admin

