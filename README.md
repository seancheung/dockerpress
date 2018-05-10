# dockerpress
A docker image with wordpress(apache2, php7) controlled by supervisor.

# Run

```bash
docker run -d --name wordpress -p 80:80 -v /var/opt/wordpress:/var/www/localhost/htdocs seancheung/dockerpress:latest
```

If not volume mounted and `WP_SKIP_DOWNLOAD` is not set, the latest wordpress will be automatically downloaded during startup

```bash
docker run -d --name wordpress -p 80:80 seancheung/dockerpress:latest
```

Connect with mysql in another container

```bash
docker network create wp
docker network connect wp wordpress
docker network connect wp mysql_container
```

Use `dockerhost` for mysql hostname when mysql runs on docker host. Otherwise use mysql container name(in the same network) instead.

## Environments

**WP_SKIP_DOWNLOAD**

Skip downloading wordpress

```bash
WP_SKIP_DOWNLOAD=true
```
