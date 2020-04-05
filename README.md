# Ubuntu 19.10 Vagrant VM: PHP 7.3
* Git
* Nginx
* PHP V7.3
* MySQL V5.7
* Redis
* Composer
* NodeJS
* Npm
* Memcached
* PHPUnit
* Zsh

# Instalación Rápida
## Instala el Software Base
1. Instalar [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Instalar [Vagrant](https://www.vagrantup.com)
3. Clona el proyecto `git clone git@github.com:<user>/ubuntu-lemp-php7.git lemp7`

## Instala Plugins Base de Vagrant
```
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hostmanager
```

## Pasos
1. Ve al directorio donde está ubicado el archivo README.md (`cd lemp7`)
2. Ejecuta `vagrant up`
3. Verifica que tu archivo hosts tenga la siguiente linea de instrucción `192.168.2.3  lemp7.vh`
4. Visita en tu navegador el siguiente enlace [lemp7](http://lemp7.vh)

# Adicionales

## Manual de Instalación de oh-my-zsh para usuario vagrant
```
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | zsh
sudo chsh -s `which zsh`
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting && \
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions && \
sed -i -e 's/git/git zsh-syntax-highlighting zsh-autosuggestions/' ~/.zshrc
sed -i -e 's/robbyrussell/risto/' ~/.zshrc
source ~/.zshrc
```

## Manual de Instalación segura de Redis
[Documentación técnica](https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04)
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
