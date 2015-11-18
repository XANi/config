class puppet {
    $puppet_repo_path = hiera('repo_path','/var/lib/dpp/repos/shared')
    $puppet_fact_path = hiera('fact_path','/tmp/facts/')
    file { puppet-conf:
        path    => '/etc/puppet/puppet.conf',
        content => template('puppet/puppet.conf.erb'),
        owner   => root,
        group   => root,
    }
    file { '/tmp/puppet.yaml':
     content => template('puppet/info.yaml'),
    }
    package {
        'puppet-common':
            ensure => latest;
        'ruby-deep-merge':
            ensure => installed;
    }
    file {
        '/etc/hiera.yaml':
            mode    => 600,
            owner   => root,
            content => template('puppet/hiera.yaml.erb');
        '/etc/puppet/hiera.yaml':
            mode    => 600,
            owner   => root,
            content => template('puppet/hiera.yaml.erb');
    }
    file {'/etc/cron.weekly/clean-puppet-reports':
        content => "#!/bin/bash\n/usr/bin/find /var/lib/puppet/reports -mtime +30 -type f -delete\n",
        mode    => 755,
    }

}
