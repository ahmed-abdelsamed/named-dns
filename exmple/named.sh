{https://two-oes.medium.com/openshift-4-in-an-air-gap-disconnected-environment-part-1-prerequisites-63f065e8a729}


yum install bind

$cat >> /etc/named.conf << EOF
zone "exmaple.com" in {
   type master;
   file "example.com.zone";
};
EOF


$vi /etc/named.conf
opetions {
....
            listen-on port 53 { 192.168.1.1; };
            ....
            forwarders {
                192.168.2.1;
                192.168.2.2;
            };

$ cat > /var/named/example.com.zone << EOF
$TTL    14400
@  1D  IN  SOA ns.exapmle.com. hostmaster.example.com. (
  2020022306 ; serial
  3H ; refresh
  15 ; retry
  1w ; expire
  3h ; nxdomain ttl
 )
   IN  NS     ns.exapmle.com.
$ORIGIN exapmle.com.
ns                    IN   A   192.168.1.1
hostmaster            IN   A   192.168.1.1
ntp                   IN   A   192.168.2.1
registry              IN   A   192.168.1.1
bastion               IN   A   192.168.1.1
haproxy-01            IN   A   192.168.1.2
haproxy-02            IN   A   192.168.1.3
vip-01                IN   A   192.168.1.4
ocp4                  IN   A   192.168.1.4
bootstrap             IN   A   192.168.1.5
master-01             IN   A   192.168.1.6
master-02             IN   A   192.168.1.7
master-03             IN   A   192.168.1.8
worker-01             IN   A   192.168.1.9
worker-02             IN   A   192.168.1.10
worker-03             IN   A   192.168.1.11
$ORIGIN ocp4.exmaple.com.
control-plane-0       IN       A   192.168.1.6
control-plane-1       IN       A   192.168.1.7
control-plane-2       IN       A   192.168.1.8
etcd-0                IN       A   192.168.1.6
etcd-1                IN       A   192.168.1.7
etcd-2                IN       A   192.168.1.8
_etcd-server-ssl._tcp IN SRV 0 10  2380 etcd-0
_etcd-server-ssl._tcp IN SRV 0 10  2380 etcd-1
_etcd-server-ssl._tcp IN SRV 0 10  2380 etcd-2
ocp4-bootstrap        IN       A   192.168.1.5
bootstrap-0           IN       A   192.168.1.5
api                   IN       A   192.168.1.4
api-int               IN       A   192.168.1.4
$ORIGIN apps.ocp4.example.com.
*                     IN       A   192.168.1.4
EOF

systemctl restart named



$ export FIREWALLD_DEFAULT_ZONE=`firewall-cmd --get-default-zone`
$ echo ${FIREWALLD_DEFAULT_ZONE}
public

$ firewall-cmd --add-port 22623/tcp --permanent --zone=${FIREWALLD_DEFAULT_ZONE}
$ firewall-cmd --add-port 6443/tcp --permanent --zone=${FIREWALLD_DEFAULT_ZONE}
$ firewall-cmd --add-service https --permanent --zone=${FIREWALLD_DEFAULT_ZONE}
$ firewall-cmd --add-service http --permanent --zone=${FIREWALLD_DEFAULT_ZONE}
$ firewall-cmd --add-port 9000/tcp --permanent --zone=${FIREWALLD_DEFAULT_ZONE}


$ firewall-cmd --reload
$ firewall-cmd --list-ports

