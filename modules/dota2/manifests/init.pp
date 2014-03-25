class dota2 {
    include dota2::vars
    include dota2::autoexec
}


class dota2::vars {
    $steamdir = '/var/xani/steam'
    $dotadir = "${steamdir}/SteamApps/common/dota 2 beta"
    $dota_user = 'xani'
}

class dota2::autoexec {
    require dota2::vars
    $basedir = $dota2::vars::dotadir
    file { "${basedir}//dota/cfg/autoexec.cfg":
        content => template('dota/autoexec.cfg'),
        owner   => xani,
        mode    => 644,
    }


}
