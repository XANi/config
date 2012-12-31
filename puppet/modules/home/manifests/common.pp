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
     $homedir = hiera('homedir','/home/xani'),
     $http_proxy = hiera('http_proxy',false),
     $https_proxy = hiera('https_proxy',false),
     $socks_proxy = hiera('socks_proxy',false),
    ) {
        util::add_user_to_group {
            'xani-fuse':
                user => 'xani',
                group => 'fuse',
        }
}
