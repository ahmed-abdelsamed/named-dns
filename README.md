# named-dns with forward to 8.8.8.8 & 8.8.4.4

sudo dnf install bind bind-utils -y
sudo apt install bind9 bind9utils bind9-doc

/etc/named.conf
--------------------------------------------
Comment out the following lines:

//listen-on port 53 { 127.0.0.1; };
//listen-on-v6 port 53 { ::1; };

allow-query     { localhost; 172.16.16.0/24; };

 allow-transfer { none; };
    forwarders {
                8.8.8.8;
                8.8.4.4;
        };

include "/etc/named/named.conf.local
-----------------------------------------
/etc/named/named.conf.local
----------------------------------------
zone "home.lab" {
    type master;
    file "/etc/named/zones/db.home.lab";
  };

zone "126.168.192.in-addr.arpa" {

    type master;
    file "/etc/named/zones/db.192.168.126";
};
-------------------------------------------
/etc/named/zones/db.home.lab 
------------------------------------------
/etc/named/zones/db.192.168.126 
----------------------------------------
named-checkzone home.lab /etc/named/zones/db.home.lab
named-checkzone 16.16.172.in-addr.arpa  /etc/named/zones/db.172.16.16



dig +noall +answer @<nameserver_ip> api.<cluster_name>.<base_domain> 

dig +noall +answer @<nameserver_ip> api-int.<cluster_name>.<base_domain>

dig +noall +answer @<nameserver_ip> random.apps.<cluster_name>.<base_domain>

dig +noall +answer @<nameserver_ip> console-openshift-console.apps.<cluster_name>.<base_domain>

dig +noall +answer @<nameserver_ip> bootstrap.<cluster_name>.<base_domain>

dig +noall +answer @<nameserver_ip> -x 192.168.1.5

dig +noall +answer @<nameserver_ip> -x 192.168.1.96
