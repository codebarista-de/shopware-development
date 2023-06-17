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

## Initial setup

See [Shopware Documentation](https://developer.shopware.com/docs/guides/installation/template).

Install PHP 8 and dependencies
```
sudo add-apt-repository ppa:ondrej/php
sudo apt-get install -y php8.1-fpm php8.1-mysql php8.1-curl php8.1-gd php8.1-xml php8.1-zip php8.1-opcache php8.1-mbstring php8.1-intl php8.1-cli
```

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
