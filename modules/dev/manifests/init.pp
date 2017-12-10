# tiny dev instance of haproxy

class dev::haproxy (
    $ip = '127.0.0.1',
    $errors_are_200 = true, #replace every error with 200 + refresh equivalent
)  {
    if $errors_are_200 {
        $errorfile_prefix = '200-'
    } else {
        $errorfile_prefix = ''
    }
    package { 'haproxy':
        ensure => installed,
    }
    service { 'haproxy':
        ensure => running,
        enable => true,
    }
    file {'/etc/haproxy/haproxy.cfg':
        content => template("${module_name}/haproxy.cfg"),
        mode    => "644",
        owner   => xani,
        notify  => Service['haproxy'],
    }
    file {'/etc/haproxy/errors/':
        ensure  => directory,
        mode    => "644",
        source  => "puppet:///modules/${module_name}/haproxy/errors",
        recurse => true,
        force   => true,
        purge   => true,
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
            '3004.localhost',
            '3005.localhost',
            '3006.localhost',
            '3007.localhost',
            '3008.localhost',
            '3009.localhost',
            '8080.localhost',
            '8081.localhost',
            'sync',
               ]:
                   ip => $host_ip
        }
    }
    include dev::haproxy::ssl
}

class dev::haproxy::ssl {
    exec {'generate-ss-cert':
        path => '/usr/bin:/usr/sbin:/bin:sbin',
        command => 'echo "\n\n\n\n\n443.localhost\n\n" |   openssl req -x509 -newkey rsa:2048 -keyout /etc/haproxy/selfsigned.pem -out /etc/haproxy/selfsigned.pem -nodes -days 30',
        creates => '/etc/haproxy/selfsigned.pem',
        require => Tidy['selfsigned-cert-rotation'],
    }
    tidy {'selfsigned-cert-rotation':
        path =>'/etc/haproxy/selfsigned.pem',
        age  => '1w',
        backup => false,
    }
}


class dev::rabbitmq {
    package {"rabbitmq-server":
        ensure => installed,
    }
    service {'rabbitmq-server':
        ensure => running,
        enable => true,
    }
}
