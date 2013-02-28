class puppet {
    $puppet_repo_path = hiera('repo_path','/var/lib/dpp/repos/shared')
    $puppet_fact_path = hiera('fact_path','/tmp/facts/')

    file { puppet-conf:
        path    => '/etc/puppet/puppet.conf',
        content => template('puppet/puppet.conf.erb'),
        owner   => root,
        group   => root,
    }
    package {
        'ruby-hiera-puppet':
            ensure => latest;
    }
    file {
        '/etc/hiera.yaml':
            mode    => 600,
            owner   => root,
            content => template('puppet/hiera.yaml.erb');
        '/etc/puppet/hiera.yaml':
            ensure => '/etc/hiera.yaml';
    }

}
