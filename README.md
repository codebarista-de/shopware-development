# Shopware 6 dev template

## Initial setup

Install [Symfony CLI](https://symfony.com/download).

Run
```
docker-compose up -d
./bin/console system:install --basic-setup
```

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
