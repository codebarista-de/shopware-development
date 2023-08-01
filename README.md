# Shopware 6 dev template

## Start

Run
```
docker-compose up -d
symfony server:start -d
```

## Stop

Run
```
symfony server:stop
docker-compose down
```

### Mail Catcher

Open http://localhost:1080/ to show mails sent by shopware.

## Initial setup

See [Shopware Documentation](https://developer.shopware.com/docs/guides/installation/template).

Install [Docker and Docker Compose](https://docs.docker.com/compose/install/linux/).

Install PHP 8 and dependencies
```
sudo add-apt-repository ppa:ondrej/php
sudo apt-get install -y php8.1-fpm php8.1-mysql php8.1-curl php8.1-gd php8.1-xml php8.1-zip php8.1-opcache php8.1-mbstring php8.1-intl php8.1-cli composer
```

In `/etc/php/8.1/fpm/php.ini` set `memory_limit = -1`.

Install [Symfony CLI](https://symfony.com/download).

Run
```
docker-compose up -d
```
Outside of the container: 
```
composer install
./bin/console system:install --basic-setup
```

Open `http://localhost:8000/admin`, login with username `admin` and password `shopware` and finish the initial setup.

Then run
```
bin/console plugin:refresh
bin/console plugin:install --activate FroshPlatformAdminer FroshDevelopmentHelper
bin/console plugin:install --activate FroshPlatformAdminer
```

