class home::configs {
    include home::common
    $homedir = $home::common::homedir
    user { xani:
        ensure => present,
        shell  => '/bin/bash',
    }

    home::configs::config {
        bashrc:;
        bash_prompt:;
        htoprc:;
        inputrc:;
        screenrc:;
        toprc:;
    }
    file {'xani-custom-bash-profile':
        path   => "$homedir/.bash_prompt_custom",
        ensure => present,
        owner  => xani,
        notify => Home::Configs::Config['bash_prompt'],
    }
    file {'xani-ssh-config-dir':
        path   => "$homedir/.ssh",
        ensure => directory,
        owner  => xani,
        mode   => 700,
    }

}
define home::configs::config (
        $source = "home/${title}.erb",
        $target = ".${title}",
        $mode   = 644,
    ) {
    include home::common
    $homedir = $home::common::homedir
    file { "${homedir}/$target":
        content => template($source),
        owner   => xani,
        mode    => $mode,
    }
}
