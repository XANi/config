class apt (
    $install_recommended = true,
    $install_suggested = false, # baaaad idea to set it to true
    {
        file { '/etc/apt/apt.conf.d/99-zpuppet.conf':
            content => template('apt/apt.conf.erb'),
        }
    }
}

class apt::source (
    $repo_types = ['deb','deb-src'] # it allows for redefining it from calling node so we can for example exclude all src repos
    ) {
    $repos = hiera('repos')
    file { apt-sources:
        path => '/etc/apt/sources.list',
        owner => root,
        mode => 644,
        content => template('apt/sources.list.erb'),
        notify => Exec['apt-update'],
    }
    exec { apt-update:
        refreshonly => true,
        command => '/usr/bin/aptitude update',
        logoutput => true,
        timeout => 0,
    }
    package { 'emdebian-archive-keyring':
        ensure => latest,
    }
}

class apt::update {
    file { apt-download-updates:
        path => '/etc/cron.daily/puppet-apt-updates',
        content => template('apt/apt-updates.erb'),
        owner => root,
        mode => 755,
    }
}
