if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root"
   exit 1
fi

echo "VIM installing.."
apt-get install -y vim 
echo "VIM successfully installed"

echo "git installing.."
apt-get install -y git 
echo "git successfully installed"

echo "openvpn installing.."
apt-get install -y openvpn
echo "openvpn successfully installed"

echo "package list updating.."
apt-get update 
echo "package list updated"

echo "apache2 installing.."
apt-get install -y apache2 
echo "apache2 successfully installed"

echo "mysql-server & php5-mysql installing.."
apt-get install -y mysql-server php5-mysql 

mysql_install_db 

mysql_secure_installation 
echo "mysql-server & php5-mysql successfully installed"

echo "php5 modules installing.."
apt-get install -y php5 libapache2-mod-php5 php5-mcrypt 

service apache2 restart 

apt-get install -y php5-cli php5-cgi php5-common php5-curl php5-dbg php5-dev php5-redis php5-mongo php5-memcache 
echo "php5 modules successfully installed"

a2enmod rewrite headers expires deflate 
echo "apache mods enabled"

service apache2 restart 
echo "apache server started"

echo "phpmyadmin installing.."
apt-get install -y phpmyadmin apache2-utils 

cp -r /usr/share/phpmyadmin/ /var/www/html/

chmod -R 777 /var/www/

echo "Include /etc/phpmyadmin/apache.conf" >>  /etc/apache2/apache2.conf
echo "phpmyadmin installed"

service apache2 restart 
echo "apache server restarted"

echo "redis-server installing.."
apt-get install -y redis-server 
echo "redis-server installed"

echo "php-pear installing.."
apt-get install -y php-pear 
echo "php-pear installed"

echo "mongo-server installing.."
pecl install mongo 
echo "mongo-server installed"

echo "creating host test.91mobiles.com"
echo "127.0.0.1       test.91mobiles.com" >>  /etc/hosts
echo "host created test.91mobiles.com"

echo "creating virtual host in /etc/apache2/apache2.conf"
echo "NameVirtualHost *:80
<VirtualHost *:80>
    DocumentRoot /var/www/html/template_engine/src/
    ServerName test.91mobiles.com
    ServerAlias test.91mobiles.com
        SetEnv MOBENV \"DEVELOPMENT\"
    <Directory /var/www/html/template_engine/src/>
    Options Indexes FollowSymLinks MultiViews
        AllowOverride ALL
    </Directory>
</VirtualHost>" >>  /etc/apache2/apache2.conf
echo "virtual host created"

echo "java installing.."
apt-add-repository -y ppa:webupd8team/java 

apt-get update 

apt-get install -y oracle-java8-installer 
echo "java installed"

echo "elasticsearch installing.."
wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -

add-apt-repository -y "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main"

apt-get update

apt-get install -y elasticsearch

service elasticsearch start
echo "elasticsearch installed"

service apache2 restart 
echo "apache server restarted"

echo "filezilla installing.."
apt-get install -y filezilla
echo "filezilla installed"

echo "gitk installing.."
apt-get install -y gitk
echo "gitk installed"








