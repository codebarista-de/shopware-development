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

### Enable debugging

Install XDebug
```
sudo apt install php-xdebug
```

Add the following lines to `/etc/php/8.1/fpm/conf.d/20-xdebug.ini`:
```
xdebug.mode = debug
xdebug.start_with_request = yes
xdebug.discover_client_host = false
xdebug.client_port = 9003
```

Install the [VSCode PHP Debug extension](https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug)
and create a launch configuration in `.vscode/launch.json` with the following content:
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for Xdebug",
            "type": "php",
            "request": "launch",
            "port": 9003
        }
    ]
}
```

Start (or restart) the shopware server.

Open the "Run and Debug" view in VS Code (`Ctrl+Shift+D`).

Start debugging (`F5`).

Set a breakpoint in the `handle` function of `vendor/shopware/core/HttpKernel.php`.

Open `http://localhost:8000`.

If everything is setup correctly the breakpoint should be hit.
