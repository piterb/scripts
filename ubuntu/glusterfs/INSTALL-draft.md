## Preinstall
Setup /etc/hosts for each node (replace with node IP)
``` bash
echo "10.0.0.2 dh1" >> /etc/hosts
echo "10.0.0.3 dh2" >> /etc/hosts
echo "10.0.0.4 dh3" >> /etc/hosts
```

## Volumes creation
This step is necessary in case volume does not exists yet

For each host (replace number 1 with host number)
``` bash
mkdir -p /gluster/bricks/1
echo "/dev/sdb /gluster/bricks/1 xfs defaults 0 0" >> /etc/fstab
mount -a
mkdir -p /gluster/bricks/1/brick
```

## Install
Install server on each node (replace glusterfs-6 with latest version)
``` bash
apt update
apt install software-properties-common -y
add-apt-repository ppa:gluster/glusterfs-6 -y
apt update
apt install glusterfs-server -y
```


## Post install - run on first node only
``` bash
systemctl enable glusterd # automatically start glusterfs on boot
systemctl start glusterd # start glusterfs right now
systemctl status glusterd # Should show status active
```

Peer to other nodes

``` bash
gluster peer probe 10.0.0.3
gluster peer probe 10.0.0.4
```

Create gluster volume

``` bash
gluster volume create gfs \
replica 3 \
gluster1:/gluster/bricks/1/brick \
gluster2:/gluster/bricks/2/brick \
gluster3:/gluster/bricks/3/brick
```

Start the volume
``` bash
gluster volume start gfs
gluster volume status gfs
gluster volume info gfs
```

Authorize nodes

`gluster volume set gfs auth.allow 10.0.0.2,10.0.0.3,10.0.0.4`

Mount the glusterFS volume where applications can access the files
``` bash
echo 'localhost:/gfs /mnt glusterfs defaults,_netdev,backupvolfile-server=localhost 0 0' >> /etc/fstab
mount.glusterfs localhost:/gfs /mnt
```