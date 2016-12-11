class dota2 {
#    include dota2::vars
#    include dota2::autoexec
#    include dota2::icons
}


class dota2::vars {
    $steamdir = '/var/steam'
    $dotadir = "${steamdir}/SteamApps/common/dota 2 beta"
    $dota_user = 'xani'
}

class dota2::autoexec {
    require dota2::vars
    $basedir = $dota2::vars::dotadir
    file { "${basedir}/dota/cfg/autoexec.cfg":
        content => template('dota2/autoexec.cfg'),
        owner   => xani,
        mode    => "644",
    }
}

class dota2::icons {
    require dota2::vars
    $basedir = $dota2::vars::dotadir
    File {
        owner => xani,
        group => xani,
        mode  => "644",
    }
    file { "${basedir}/dota/resource/flash3/images":
        ensure => directory,
    }
    file { "${basedir}/dota/resource/flash3/images/items":
        ensure  => directory,
        source  => "puppet:///modules/dota2/item_icons",
        recurse => true,
    }
}
