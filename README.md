# Ubuntu 16.04 Vagrant VM: PHP 7
* Git
* Nginx
* PHP7
* MySQL
* Redis
* Composer
* NodeJS
* Npm
* Gulp
* Memcached
* PHPUnit

# Quick install
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](https://www.vagrantup.com/)
3. Clone this project `git clone git@github.com:marcotorres/ubuntu-lemp-php7.git`
4. Go to directory with README file (`cd vagrant-php7-phalcon`)
5. Run `vagrant up`
6. Edit host file `sudo nano /etc/hosts`  >> 192.168.3.42  site.vh
7. Vagrant box Nginx virtual host
   `cd  /etc/nginx/sites-available`
   `sudo touch site.vh.conf`
   `sudo nano site.vh.conf` 
   
   server {
       # General
       charset utf-8;
   
       # Log files for Debugging
           access_log /var/log/nginx/site.vh_access.log;
           error_log /var/log/nginx/site.vh_error.log;
   
       # Webroot Directory for project
           root /var/www/site.vh;
           index index.php index.html index.htm;
   
       # Your Domain Name
       server_name site.vh;
   
       # Check file exist and send request sting to index.php
       location / {
           try_files $uri $uri/ /index.php$is_args$args;
       }
   
       # Allow execute all php files
           location ~ \.php$ {
           try_files $uri =404;
           fastcgi_split_path_info ^(.+\.php)(/.+)$;
   
          #fastcgi_pass  unix:/var/run/php/php7.1-fpm.sock;
           fastcgi_pass  127.0.0.1:9000;
   	       fastcgi_index /index.php;
   
           include fastcgi_params;
           fastcgi_split_path_info       ^(.+\.php)(/.+)$;
           fastcgi_param PATH_INFO       $fastcgi_path_info;
           fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
           fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
       }
   
       # Turn off cache
       location ~* ^.+\.(js|css)$ {
           expires -1;
           sendfile off;
       }
   
       # Disallow access to apache configs
       location ~ /\.ht {
           deny all;
       }
   
       # Disallow access to git configs path
       location ~ /\.git {
           deny all;
       }
   }
   
   `sudo ln -s /etc/nginx/sites-available/site.vh.conf /etc/nginx/sites-enabled/site.vh`
    
# Development
1. Go to `cd /var/www/`
2. Make `mkdir site.vh`
3. Restart Nginx and PHP
   `sudo service nginx restart`
   `sudo service php7.0-fpm restart`
4. Open url `http://site.vh/`
5. Enjoy :sunglasses:

# MySQL
* login: `root`
* password: `root`
