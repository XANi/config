class token {
    exec {'add-to-card-group':
        command => 'usermod -G scard xani',
        unless  => 'id xani |grep scard',
        path    => [
                    '/sbin',
                    '/bin',
                    '/usr/sbin',
                    '/usr/bin',
                    '/usr/local/sbin',
                    '/usr/local/bin',
                    ],
        require => Package['opensc'],
    }
    if $lsbdistid == 'Debian' {
        # for some retarded reason opensc 0.12 developers
        # decided it would be a good idea to hardcode which backend to use
        # and alladin is working only with openct, so we use squeeze version
        package {'opensc':
            ensure => '0.11.13-1.1',
        }
        package {'openct':
            ensure => installed,
        }
    }

}
