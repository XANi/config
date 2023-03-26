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
    $homedir     = lookup('homedir',undef,undef,'/home/xani'),
    $http_proxy  = lookup('http_proxy',undef,undef,false),
    $https_proxy = lookup('https_proxy',undef,undef,false),
    $socks_proxy = lookup('socks_proxy',undef,undef,false),
    $no_proxy    = lookup('no_proxy',undef,undef,false),
    $perl5lib    = lookup('perl5lib',undef,undef,false),
    $git         = lookup('git'),
)  {
    util::add_user_to_group {
        'xani-fuse':
            user  => 'xani',
            group => 'fuse',
    }
    # for serial ports
    util::add_user_to_group {
        'xani-dialout':
            user  => 'xani',
            group => 'dialout',
    }
}
