class ssl {
    exec { 'update-ca-certificates':
        command     => 'update-ca-certificates',
        refreshonly => true,
    }
}




define ssl::cert {
    include ssl
    file { "/etc/ssl/certs/puppet-${title}.pem":
        source => "puppet:///modules/ssl/certs/${title}.pem",
        mode   => 644,
        owner  => root,
        notify => Exec['update-ca-certificates'],
    }
}
