class token {
    package {['pcscd','openct','opensc']:
        ensure => absent,
    }

    file {'/usr/local/bin/token-agent.sh':
        content => template('token/token-agent.sh.erb'),
        mode    => 755,
        owner   => root,
    }
    file {'/etc/udev/rules.d/99-yubikey.rules':
        content => template('token/yubikey.udev'),
        mode    => 644,
        owner   => root,
    }
}
