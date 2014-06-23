#!/usr/bin/env bash

##
# Bash script to provision VM, used to set up test environment.
# The is the correct home for one time builds/installations 
# required to set up the demonstrators.
#
# Be aware this script is only the first time you issue the
#    vagrant up
# command, or following a
#    vagrant destroy
#    vagrant up
# combination.  See the README for further details.
##

# Add openplanets Bintray deb repo and update apt repos
echo "deb http://dl.bintray.com/openplanets/opf-debian /" >> /etc/apt/sources.list 
apt-get update

# Install firefox and Java for data journal
apt-get install -y openjdk-7-jre-headless tomcat6

# tomcat
/etc/init.d/tomcat6 restart

# data journal
echo "setting up the data journal"
ln -fs /vagrant/datajournal/webapps/datajournal.war /var/lib/tomcat6/webapps/datajournal.war
ln -fs /vagrant/datajournal/datajournal.properties /var/lib/tomcat6/datajournal.properties

# fc repo
echo "setting up the fc repo"
if [ ! -f /vagrant/datajournal/webapps/fcrepo.war ] 
	then
	wget https://docs.google.com/uc?export=download&confirm=wvS0&id=0B5nd_qlYdcqyM0pNbmJrSzh1dW8
	mv fcrepo.war /vagrant/datajournal/webapps/
fi
ln -fs /vagrant/datajournal/webapps/fcrepo.war /var/lib/tomcat6/webapps/fcrepo.war
/etc/init.d/tomcat6 restart
# now replace jars with iro ones
cp /vagrant/datajournal/webapps/scape-platform-datamodel-0.1.8-SNAPSHOT.jar /var/lib/tomcat6/webapps/fcrepo/WEB-INF/lib/
cp /vagrant/datajournal/webapps/iro-0.0.1-SNAPSHOT.jar /var/lib/tomcat6/webapps/fcrepo/WEB-INF/lib/
echo 'JAVA_OPTS="${JAVA_OPTS} -Dfcrepo.home=/tmp/fcrepo4-home -Dscap.fcrepo.content.referenced=true"' >> /etc/default/tomcat6
/etc/init.d/tomcat6 restart

# fuseki
echo "setting up fuseki"
apt-get install unzip
useradd -m fuseki
cd /home/fuseki
su - fuseki
wget http://apache.mirror.1000mbps.com/jena/binaries/jena-fuseki-1.0.2-distribution.zip
unzip jena-fuseki-1.0.2-distribution.zip
cd jena-fuseki-1.0.2
chmod a+x s-*
mkdir ROData
chown fuseki * -R
echo "starting up fuseki"
su fuseki -c'nohup ./fuseki-server --loc=ROData --update /ResearchObject' &

sleep 5
echo "load IRO data"
unset http_proxy;./s-update --service http://localhost:3030/ResearchObject/update 'CLEAR GRAPH <ROData>'
unset http_proxy;./s-put http://localhost:3030/ResearchObject/data ROData /vagrant/datajournal/testData.ttl

echo "load pankos data"
unset http_proxy;./s-update --service http://localhost:3030/ResearchObject/update 'CLEAR GRAPH <pankos>'
unset http_proxy;./s-put http://localhost:3030/ResearchObject/data pankos /vagrant/datajournal/pankos.ttl
exit

