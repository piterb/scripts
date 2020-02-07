# Docker snippets

## Add swarm network
`docker network create -d overlay --attachable <network_name>`

## Add web server

``` bash
docker run -d -p <port_in_host>:<port_in_container> --network <network_name> --name=<container_name> -v <apache2_sites_config_folder>:/etc/apache2/sites-available -v <webroot_on_host>:<web_root_container>  <image>
```

### Example
``` bash
docker run -d -p 80:80 --network php5 --name=php5_app1 -v /mnt/gluster/myweb/apache2:/etc/apache2/sites-available -v /mnt/gluster/myweb/www:/var/www/myweb  php:7.2-apache
```

## Add web server service
`docker service create -p <port_in_host>:<port_in_container> --name <service_name> --network <network_name> --mount type=bind,source=<host_folder>,destination=<container_folder> --config source="<config_name_in_registry>",target="<config_path_in_container>",mode=<permissions> --replicas=<number_of_replicas> <image>`

### Example
`docker service create -p 80:80 --name php5_superobedsk --network php5 --mount type=bind,source=/mnt/gluster/myweb/www,destination=/var/www/myweb --config source="000-default-myweb.conf",target="/etc/apache2/sites-available/000-default.conf",mode=0644 --replicas=3 php:7.2-apache`

### Legacy images
nimmis/apache-php5:latest

## Add mysql server
`docker run -d --network <network_name> --name=<container_name> -v <host_folder>:<container_folder> --env="MYSQL_ROOT_PASSWORD=<root_password>" --env="MYSQL_PASSWORD=<mysql_password>" --env="MYSQL_DATABASE=<database_to_create>"<image>`

### Example
`docker run -d --network mynetwork --name=mysqldb -v /mnt/gluster/mydb/mysql:/etc/mysql/conf.d --env="MYSQL_ROOT_PASSWORD=change_me" --env="MYSQL_PASSWORD=change_me" --env="MYSQL_DATABASE=mydb1" latest`

### Legacy images
mysql:5.6

## Import data to mysql
`docker exec -i <container_name> mysql -u<user_name> -p<password> <db_name> < <path_to_sql>`

### Example
`docker exec -i mysqldb mysql -uroot -pRoot123 mydb1 < /mnt/gluster/mydb/mydb1.sql`

## Add phpMyAdmin
`docker run --name <container_name> --network <network_name> -d -e PMA_HOST=<mysql_server_address> -e PMA_ARBITRARY=1 -p <port_on_host>:<port_in_container> phpmyadmin/phpmyadmin`

### Example
`docker run --name phpmyadmin_app1 --network app1 -d -e PMA_HOST=10.0.0.10 -e PMA_ARBITRARY=1 -p 8080:80 phpmyadmin/phpmyadmin`
