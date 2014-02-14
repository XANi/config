class dota2 {
    include dota2::vars
    include dota2::autoexec
    include dota2::itembuilds
}


class dota2::vars {
    $steamdir = '/tmp'
    $dotadir = "${steamdir}/SteamApps/common/dota 2 beta"
    $dota_user = 'xani'
}

class dota2::itembuilds {
    include dota2
    $dotadir = $dota2::vars::dotadir
    $dotauser = $dota2::vars::dota_user
    file { "${dotadir}/dota/itembuilds/":
        ensure => directory,
        source => 'puppet:///modules/dota2/itembuilds',
        recurse => true,
        owner  => $dotauser
    }
}
class dota2::autoexec {
    notify {"Autoexec goes here":;}

}
