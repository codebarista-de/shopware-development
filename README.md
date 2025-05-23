# Shopware 6 dev template

## Start/Stop

Run the `start_server.sh` script.
Press `CTRL+C` to stop the webserver and all docker services.

### Manually

To start the server and all required services run:
```
docker-compose up -d
symfony server:start -d
```

To stop everything run:
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
sudo apt-get install -y php8.3-fpm php8.3-mysql php8.3-curl php8.3-gd php8.3-xml php8.3-zip php8.3-opcache php8.3-mbstring php8.3-intl php8.3-cli composer
```

In `/etc/php/8.3/fpm/php.ini` set `memory_limit = -1`.

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

Start the server:
```
symfony server:start -d
```
Open `http://localhost:8000/admin`, login with username `admin` and password `shopware` and finish the initial setup.

Then run
```
bin/console plugin:refresh
bin/console plugin:install --activate FroshPlatformAdminer FroshDevelopmentHelper
bin/console plugin:install --activate FroshPlatformAdminer
```

## Run static analyzer

Will run static analysis on all PHP files in `custom/plugins/` except those of shopware plugins:
```
vendor/bin/phpstan analyze
```

### Enable debugging

Install XDebug
```
sudo apt install php-xdebug
```

Add the following lines to `/etc/php/8.3/fpm/conf.d/20-xdebug.ini`:
```
xdebug.mode = debug
xdebug.start_with_request = yes
xdebug.discover_client_host = false
xdebug.client_port = 9003
xdebug.log_level = 0
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

Add this line to `/etc/php/8.3/fpm/conf.d/20-xdebug.ini` to supress the "Could not connect" warning when not debugging:
```
xdebug.log_level = 0
```

### Update shopware

Start the server and all required servicers and run:
```
bin/console system:update:prepare
```

Then execute:
```
composer update
```
Check and commit the new `composer.lock` file (do not push yet)

Run:
```
composer recipes:update
```

Add the new files and amend the previous commit.

Run:
```
bin/console system:update:finish
```

Make sure that everything works.

Push the commit.

#### Updating Dev Plugins

FroshDevelopmentHelper and FroshPlatformAdminer are installed through composer.
New versions are automatically installed through the update procedure above.
The final update step has to be done with the console:

```sh
bin/console plugin:update FroshDevelopmentHelper FroshPlatformAdminer
```