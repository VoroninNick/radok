# Setup

### config/database.yml

Setup according to your local creds.

### config/secrets.yml

Example:

```yml
development:
  secret_token: 'tocken'
  secret_key_base: '__pasted from rake secret___'
test:
  secret_token: 'tocken'
  secret_key_base: '__pasted from rake secret___'
production:
  secret_token: 'tocken'
  secret_key_base: '__pasted token from config/initializers/secret_token.rb___'
```

### settings/development.yml

```yml
mailer:
  service: smtp
  host: 10g-force.com

  sandmail:
    location:  __location__
    arguments: __arguments__

  yandex:
    address: 'smtp.yandex.ru'
    domain: 'yandex.ru'
    port: 25

    email: __email__
    password: __password__
    authentication: plain
  gmail:
    address: "smtp.gmail.com"
    port: 25
    domain: __domain__
    email: __email__
    password: __password__
    authentication: plain
omniauth:
  facebook:
    app_id: __ID OR KEY__
    app_secret: __SECRET KEY__
  google_oauth2:
    client_id: __ID OR KEY__
    client_secret: __SECRET KEY__
  linkedin:
    client_id: __ID OR KEY__
    client_secret: "m0O3H4ra8nmgEVpi"
  twitter:
    consumer_key: __ID OR KEY__
    consumer_secret: __SECRET KEY__
  github:
    client_id: __ID OR KEY__
    client_secret: __SECRET KEY__

```


### After setup

run

```bash
$ bundle
...
$ rake db:create && rake db:migrate
...
$ rails s
```


### Deploy and server commands

0 Pre requirements

you need to have folder named /pem_keys in the same folder where app directory is stored

```
/pem_keys
/10g-force
```

inside `pem_keys` directory, you should have app pem key '10GKEY.pem'

1 key permitions

`$ chmod 600 ../pem_keys/10GKEY.pem`

2. Deploy

```
$ git checkout master
$ git pull origin master
$ git pull origin master
$ bundle
$ cap production deploy
```

2 Logs

```
$ cap production logs:tail_rails
# additional logs
$ cap production logs:tail_unicorn
# http request logs (NGINX)
$ cap production logs:nginx_error
$ cap production logs:nginx_access
```
