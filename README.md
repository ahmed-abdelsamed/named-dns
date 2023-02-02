# named-dns with forward to 8.8.8.8 & 8.8.4.4

dig +noall +answer @<nameserver_ip> api.<cluster_name>.<base_domain> 

dig +noall +answer @<nameserver_ip> api-int.<cluster_name>.<base_domain>

dig +noall +answer @<nameserver_ip> random.apps.<cluster_name>.<base_domain>

dig +noall +answer @<nameserver_ip> console-openshift-console.apps.<cluster_name>.<base_domain>

dig +noall +answer @<nameserver_ip> bootstrap.<cluster_name>.<base_domain>

dig +noall +answer @<nameserver_ip> -x 192.168.1.5

dig +noall +answer @<nameserver_ip> -x 192.168.1.96
