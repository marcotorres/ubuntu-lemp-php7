# Ubuntu 18.10 Vagrant VM: PHP 7.3
* Git
* Nginx
* PHP V7.3
* MySQL V5.7
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
Instala dependencias de Vagrant
`vagrant plugin install vagrant-vbguest`
`vagrant plugin install vagrant-hostmanager`
4. Go to directory with README file (`cd ubuntu-lemp-php7`)
5. Run `vagrant up`
6. Edit host file `sudo nano /etc/hosts`  >> 192.168.2.4  site.vh
7. Vagrant box Nginx virtual host
   `cd  /etc/nginx/sites-available`
   `sudo touch site.vh.conf`
   `sudo nano site.vh.conf`

   ```
   server {

       charset utf-8;

       access_log /var/log/nginx/site.vh_access.log;
       error_log /var/log/nginx/site.vh_error.log;

       root /var/www/site.vh;
       index index.php index.html index.htm;

       server_name site.vh;

       location / {
           try_files $uri $uri/ /index.php$is_args$args;
       }

       location ~ \.php$ {
           try_files $uri =404;
           fastcgi_split_path_info ^(.+\.php)(/.+)$;

           fastcgi_pass  127.0.0.1:9000;
           fastcgi_index /index.php;

           include fastcgi_params;
           fastcgi_split_path_info       ^(.+\.php)(/.+)$;
           fastcgi_param PATH_INFO       $fastcgi_path_info;
           fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
           fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
       }

       location ~* ^.+\.(js|css)$ {
           expires -1;
           sendfile off;
       }

       location ~ /\.ht {
           deny all;
       }

       location ~ /\.git {
           deny all;
       }
   }
   ``

   `sudo ln -s /etc/nginx/sites-available/site.vh.conf /etc/nginx/sites-enabled/site.vh`

# Development
1. Go to `cd /var/www/`
2. Make `mkdir site.vh`
3. Restart Nginx and PHP
   `sudo service nginx restart`
   `sudo service php7.3-fpm restart`
4. Open url `http://site.vh/`
5. Enjoy :sunglasses:

# MySQL Safe Manual Installation
 ```
sudo apt install mysql-server
mysql_secure_installation
mysql
SELECT user,authentication_string,plugin,host FROM mysql.user;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root
FLUSH PRIVILEGES;
SELECT user,authentication_string,plugin,host FROM mysql.user;
exit
systemctl status mysql.service
mysqladmin -p -u root version
 ```
   
* login: `root`
* password: `root`

# Redis Safe Manual Installation
https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04
 ```
sudo apt install redis-server
sudo vim /etc/redis/redis.conf > supervised systemd
sudo systemctl restart redis.service
sudo systemctl status redis
sudo redis-cli
> ping
sudo vim /etc/redis/redis.conf > bind 127.0.0.1 ::1
sudo systemctl restart redis
sudo netstat -lnp | grep redis
sudo vim /etc/redis/redis.conf
sudo openssl rand 60 | openssl base64 -A
sudo requirepass foobared > change pass
sudo systemctl restart redis.service
```

# ZSH Manual Installation
```
sudo apt-get install zsh
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | zsh
sudo chsh -s `which zsh`
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
vim ~/.zshrc
# en plugins agregar: zsh-syntax-highlighting zsh-autosuggestions
source ~/.zshrc
```
