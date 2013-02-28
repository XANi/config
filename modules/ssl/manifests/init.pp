class ssl {
    exec { 'update-ca-certificates':
        command     => 'update-ca-certificates',
        refreshonly => true,
        logoutput   => true,
    }
}




define ssl::cert {
    include ssl
    file { "/usr/local/share/ca-certificates/puppet-${title}.crt":
        source => "puppet:///modules/ssl/certs/${title}.pem",
        mode   => 644,
        owner  => root,
        notify => Exec['update-ca-certificates'],
    }
}
