class token {
    util::add_user_to_group {
        'xani-pcscd':
            user    => 'xani',
            group   => 'pcscd',
            require => Package['pcscd'],
    }
    package {'pcscd':
        ensure => installed,
    }
    service {[
              'pcscd',
              'openct',
              ]:
                  enable => false, # we use gpg
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
    file {'/etc/udev/rules.d/99-yubikey.rules':
        content => template('token/yubikey.udev'),
        mode    => 644,
        owner   => root,
    }
}
