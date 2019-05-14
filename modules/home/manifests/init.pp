class home {
    include home::common
    include home::config
    include home::packages
    include home::tweaks
}

define home::dir ($mode = '755') {
    include home::common
    $homedir = $home::common::homedir
    file { "${homedir}/${title}":
        ensure => directory,
        owner  => xani,
        group  => xani,
        mode   => $mode,
    }
}
