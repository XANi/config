class dpp {
    $repo_config = hiera('repo')
    $manager_url = hiera('manager_url',false)
    file { '/etc/dpp.conf':
        content => template('dpp/dpp.conf.erb'),
        mode => 600,
        owner => root,
    }

    exec {'checkout-repo':
        # use http, most "compatible" with crappy firewall/corporate networks
        command => '/bin/bash -c "cd /usr/src;git clone http://github.com/XANi/dpp.git"',
        creates => '/usr/src/dpp/.git/config',
        logoutput => true,
    }
}

