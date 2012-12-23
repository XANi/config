# install required deps  before we can use main catalog
$puppet_header = "temporary bootstrap config"
package {'ruby-hiera-puppet':
    ensure => installed;
}

file {
    '/etc/hiera.yaml':
        mode    => 644,
        owner   => root,
        content => template('puppet/hiera.yaml.erb');
    '/etc/puppet/hiera.yaml':
        ensure => '/etc/hiera.yaml';
}
