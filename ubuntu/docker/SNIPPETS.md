# Docker snippets

## Add swarm network
`docker network create -d overlay --attachable `**`network_name`**

## Add web server service
`docker service create -p `**`port_in_host`**`:`**`port_in_container`**` --name `**`service_name`** --network `**`network_name`**` --mount type=bind,source=`**`host_folder`**`,destination=`**`container_folder`**` --config source="`**`config_name_in_registry`**`",target="`**`config_path_in_container`**`",mode=`**`permissions`**` --replicas=`**`number_of_replicas`**` `**`image`**``
