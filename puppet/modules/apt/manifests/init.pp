class apt (
    $install_recommended = true,
    $install_suggested = false, # baaaad idea to set it to true
    ) {
        file { '/etc/apt/apt.conf.d/99-zpuppet.conf':
            content => template('apt/apt.conf.erb'),
            mode    => 644,
            owner   => root,
        }
}


class apt::source (
    $repo_types = ['deb','deb-src'] # it allows for redefining it from calling node so we can for example exclude all src repos
    ) {
    $repos = hiera('repos')
    file { apt-sources:
        path    => '/etc/apt/sources.list',
        owner   => root,
        mode    => 644,
        content => template('apt/sources.list.erb'),
        notify  => Exec['apt-update'],
    }
    file { local-apt-sources:
        path    => '/etc/apt/local-sources.list',
        replace => no,
        content => "# /etc/apt/local-sources.list\n# put local, test or machine-specific repos here\n\n",
        mode    => 644,
    }

    exec { apt-update:
        refreshonly => true,
        command     => '/usr/bin/aptitude update',
        logoutput   => true,
        timeout     => 0,
    }
    package { 'emdebian-archive-keyring':
        ensure => latest,
    }
}

class apt::update {
    file { apt-download-updates:
        path    => '/etc/cron.daily/puppet-apt-updates',
        content => template('apt/apt-updates.erb'),
        owner   => root,
        mode    => 755,
    }
}
define apt::key(
    $keyid,
    $ensure = 'present',
    $keyserver = 'keyserver.ubuntu.com'
) {
    case $ensure {
        present: {
            exec { "Import ${keyid} to apt keystore":
                path        => '/bin:/usr/bin',
                environment => 'HOME=/root',
                command     => "gpg --keyserver ${keyserver} --recv-keys ${keyid} && gpg --export --armor ${keyid} | apt-key add -",
                user        => 'root',
                group       => 'root',
                unless      => "apt-key list | grep ${keyid}",
                logoutput   => on_failure,
            }
        }
        absent:  {
            exec { "Remove ${keyid} from apt keystore":
                path        => '/bin:/usr/bin',
                environment => 'HOME=/root',
                command     => "apt-key del ${keyid}",
                user        => 'root',
                group       => 'root',
                onlyif      => "apt-key list | grep ${keyid}",
            }
        }
        default: {
            fail "Invalid 'ensure' value '${ensure}' for apt::key"
        }
    }
}
