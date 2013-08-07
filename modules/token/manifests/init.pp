class token {
    util::add_user_to_group {
        'xani-scard':
            user    => 'xani',
            group   => 'pcscd',
            require => Package['pcscd'],
    }
    package {'pcscd':
        ensure => installed,
    }
    if $lsbdistid == 'Debian' {
        package {'opensc':
            ensure => installed,
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
