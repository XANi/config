class token {
    util::add_user_to_group {
        'xani-scard':
            user    => 'xani',
            group   => 'scard',
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

    file {'/usr/local/bin/token-agent.sh':
        content => template('token/token-agent.sh.erb'),
        mode    => 755,
        owner   => root,
    }
}
