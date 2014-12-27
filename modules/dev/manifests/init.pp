# tiny dev instance of haproxy

class dev::haproxy (
    $ip = '127.0.0.1',
 {
    package { 'haproxy':
        ensure => installed,
    }
    service { 'haproxy':
        ensure => running,
        enable => true,
    }
    file {'/etc/haproxy/haproxy.cfg':
        content => template("${module_name}/haproxy.cfg"),
        mode    => 644,
        notify  => Service['haptoxy'],
    }
    if ($ip =~ /^127.0.0/) {
        $host_ip = $ip
    } elsif ($ip =~ /0.0.0.0/) {
        $host_ip = '127.0.0.1'
    } else {
        $host_ip = false
    }
    if $host_ip {
        host {[
            'stats.localhost',
            '3000.localhost',
            '3001.localhost',
            '3002.localhost',
            '3003.localhost',
            '8080.localhost',
            '8081.localhost',
               ]:
                   ip => $host_ip
        }
    }

}
