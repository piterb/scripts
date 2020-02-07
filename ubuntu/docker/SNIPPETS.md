# Docker snippets

## Add swarm network
`docker network create -d overlay --attachable <network_name>`

## Add web server service
`docker service create -p <port_in_host>:<port_in_container> --name <service_name> --network <network_name> --mount type=bind,source=<host_folder>,destination=<container_folder> --config source="<config_name_in_registry>",target="<config_path_in_container>",mode=<permissions> --replicas=<number_of_replicas> <image>`

### Example
`docker service create -p 80:80 --name php5_superobedsk --network php5 --mount type=bind,source=/mnt/gluster/myweb/www,destination=/var/www/myweb --config source="000-default-myweb.conf",target="/etc/apache2/sites-available/000-default.conf",mode=0644 --replicas=3 php:7.2-apache`

## Add mysql server
docker run -d --network php5 --name=mysql56-1 -v /mnt/gluster/superobed/mysql:/etc/mysql/conf.d --env="MYSQL_ROOT_PASSWORD=Hprem_767" --env="MYSQL_PASSWORD=Hprem_767" --env="MYSQL_DATABASE=superobedsk1" mysql:5.6
