class dpp {
    $repo_config = hiera('repo')

    file { '/etc/dpp.conf':
        content => template('dpp/dpp.conf.erb'),
        mode => 600,
        owner => root,
    }
}
