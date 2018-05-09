# dockerpress
A docker image with wordpress(mysql, apache2, php7) controlled by supervisor.

# Run

```bash
docker run -d --name wordpress -p 80:80 -e "MYSQL_DATABASE=wordpress" -v /var/opt/wordpress:/var/www/localhost/htdocs seancheung/dockerpress:latest
```

If not volume mounted and `WP_SKIP_DOWNLOAD` is not set, the latest wordpress will be automatically downloaded during startup

```bash
docker run -d --name wordpress -p 80:80 -e "MYSQL_DATABASE=wordpress" seancheung/dockerpress:latest
```

## Environments

**MYSQL_ROOT_PASSWORD**

Set mysql root password

**MYSQL_USER**

Create one or more user(s). Password will be the same as username if omitted. For multiple user creation, seperate them with ";".

```bash
MYSQL_USER=username:password
MYSQL_USER=username
MYSQL_USER=user1:pass1;user2:pass2
MYSQL_USER=user1;user2
MYSQL_USER=user1:pass1:user2;user3
```

**MYSQL_DATABASE**

Create one or more database(s). Username will be the same as database if omitted. User will be created(with password the same as username) if not exist. For multiple database creation, seperate them with ";".

```bash
MYSQL_DATABASE=username@database
MYSQL_DATABASE=database
MYSQL_DATABASE=username@database1;username@database2
MYSQL_DATABASE=database1;database2
MYSQL_DATABASE=user1@database1;user2@database2;database3
```

**MYSQL_SKIP_INIT**

Skip database initialization

```bash
MYSQL_SKIP_INIT=true
```

**WP_SKIP_DOWNLOAD**

Skip downloading wordpress

```bash
WP_SKIP_DOWNLOAD=true
```
