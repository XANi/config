# Class: home::common
#
#   common vars for other classess
#
# Parameters:
#
# Actions:
#
# Requires:
#
#
# Sample Usage:
#
#
#
class home::common (
    $homedir     = hiera('homedir','/home/xani'),
    $http_proxy  = hiera('http_proxy',false),
    $https_proxy = hiera('https_proxy',false),
    $socks_proxy = hiera('socks_proxy',false),
    $perl5lib    = hiera('perl5lib',false),
)  {
    util::add_user_to_group {
        'xani-fuse':
            user  => 'xani',
            group => 'fuse',
    }
    file {'/var/tmp/xani':
        ensure => directory,
        owner  => xani,
        mode   => 700,
    }
    file {'/tmp/xani':
        ensure => '/var/tmp/xani',
    }
    file {'/etc/cron.daily/cleanup_tmp.sh':
        content => template('home/cleanup_tmp.sh'),
        mode    => 755,
    }
}
