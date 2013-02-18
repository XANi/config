class ssl {
    exec { 'update-ca-certificate':
        command     => 'update-ca-certificates',
        refreshonly => true,
    }
}




define ssl::cert {
    include ssl
    file { "/etc/ssl/certs/puppet-${title}.pem":
        source => "file:///modules/ssl/certs/${title}.pem",
        mode   => 644,
        owner  => root,
        notify => Exec['update-ca-certificates'],
    }
}
