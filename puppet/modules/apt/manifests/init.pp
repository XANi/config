class apt {

}

class apt::source {
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
