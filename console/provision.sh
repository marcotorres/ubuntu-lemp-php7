#!/usr/bin/env bash

main() {
  startGo
  setupGo
  toolsGo
  nginxGo
  mysqlGo
  phpGo
  composerGo
  nodeGo
  zshGo
  endGo
}

startGo() {
  echo "========    Lemp7 BOX - START   ========" && \
  echo -e "========================================" && \
  sudo bash -c "echo '127.0.1.1   ubuntu-disco-dingo' >> /etc/hosts"
}

setupGo() {
  echo "---------------   SETUP   --------------" && \
  echo -e "----------------------------------------" && \
  export LC_ALL=en_US.UTF-8 && \
  export LANG=en_US.UTF-8 && \
  sudo add-apt-repository -y ppa:ondrej/nginx && \
  sudo add-apt-repository -y ppa:ondrej/php && \
  sudo apt-get update
}

toolsGo() {
  echo "---------------   TOOLS   --------------" && \
  echo -e "----------------------------------------" && \
  sudo apt-get install -y re2c libpcre3-dev gcc mc grc cowsay figlet zsh lsb-core
}

nginxGo() {
  echo "---------------   NGINX   --------------" && \
  echo -e "----------------------------------------" && \
  sudo apt-get install -y nginx && \
  sudo cp /vagrant/data/nginx/lemp7.vh.conf /etc/nginx/sites-available/lemp7.vh.conf && \
  sudo ln -s /etc/nginx/sites-available/lemp7.vh.conf /etc/nginx/sites-enabled/lemp7.vh && \
  sudo systemctl restart nginx.service
}

mysqlGo() {
  echo "---------------   MYSQL   --------------" && \
  echo -e "----------------------------------------" && \
  sudo apt-get install -y mysql-server && \
  sudo cp /vagrant/data/mysql/.my.cnf /root/.my.cnf && \
  sudo chmod 600 /root/.my.cnf && \
  sudo service mysql start && \
mysql --user=root <<EOF
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';  	
  FLUSH PRIVILEGES;
EOF
}

phpGo() {
  echo "----------------   PHP   ---------------" && \
  echo -e "----------------------------------------" && \
  sudo apt-get install -y php7.3-fpm php7.3-mysql php7.3-phpdbg php7.3-mbstring php7.3-gd php-imagick && \
  sudo apt-get install -y php7.3-pgsql php7.3-pspell php7.3-recode php7.3-tidy php7.3-intl php7.3-curl && \
  sudo apt-get install -y php7.3-zip php7.3-xml php7.3-dev php-memcached mcrypt memcached phpunit && \
  sudo cp /vagrant/data/php/lemp.ini /etc/php/7.3/mods-available/lemp.ini && \
  sudo chmod 644 /etc/php/7.3/mods-available/lemp.ini && \
  sudo ln -s /etc/php/7.3/mods-available/lemp.ini /etc/php/7.3/cli/conf.d/100-lemp.ini && \
  sudo ln -s /etc/php/7.3/mods-available/lemp.ini /etc/php/7.3/fpm/conf.d/100-lemp.ini && \
  sudo pecl install xdebug && \
  sudo cp /vagrant/data/php/xdebug.ini /etc/php/7.3/mods-available/xdebug.ini && \
  sudo chmod 644 /etc/php/7.3/mods-available/xdebug.ini && \
  sudo ln -s /etc/php/7.3/mods-available/xdebug.ini /etc/php/7.3/cli/conf.d/105-xdebug.ini && \
  sudo ln -s /etc/php/7.3/mods-available/xdebug.ini /etc/php/7.3/fpm/conf.d/105-xdebug.ini && \
  sudo systemctl restart php7.3-fpm
}

composerGo() {
  echo "--------------   COMPOSER   ------------" && \
  echo -e "----------------------------------------" && \
  curl -sS https://getcomposer.org/installer | php && \
  sudo mv composer.phar /usr/local/bin/composer
}

nodeGo() {
  echo "----------------   NODE   --------------" && \
  echo -e "----------------------------------------" && \
  sudo apt install -y nodejs npm
}

zshGo() {
  echo "----------------   ZSH   ---------------" && \
  echo -e "----------------------------------------" && \
  cd /tmp && wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh && \
  sudo sh ./install.sh && rm ./install.sh && usermod --shell /bin/zsh root && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting && \
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions && \
  sed -i -e 's/git/git zsh-syntax-highlighting zsh-autosuggestions/' ~/.zshrc && \
  sed -i -e 's/robbyrussell/risto/' ~/.zshrc
}

endGo() {
  sudo usermod -a -G www-data vagrant && \
  echo "=========    Lemp7 BOX - END   =========" && \
  echo -e "========================================" && \
  figlet Lemp7 && \
  cowsay -f milk "Nunca confies en un ordenador que no puedas lanzar por una ventana. --->Steve Wozniak"
}

main
exit 0
