class home::config {
    include home::common
    $homedir = $home::common::homedir
    user { xani:
        ensure => present,
        shell  => '/bin/bash',
    }

    home::config::file {
        bashrc:;
        bash_prompt:;
        htoprc:;
        inputrc:;
        screenrc:;
        toprc:;
    }
    home::config::code_tmp {
        erb:;
        pl:;
        pp:;
        sh:;
    }
    file {'xani-ssh-config-dir':
        path   => "$homedir/.ssh",
        ensure => directory,
        owner  => xani,
        mode   => 700,
    }
    file { 'xani-ssh-config':
        path    => "$homedir/.ssh/config",
        content => template('home/ssh_config.erb'),
        owner   => xani,
        group   => xani,
        mode    => 600,
        require => File['xani-ssh-config-dir'],
    }

}
define home::config::file (
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


define home::config::code_tmp (
    $source = "home/code_tmp/${title}.erb",
    $target = "/tmp/1.${title}",
    ) {
    file { $target:
        content => template($source),
        mode    => 755,
        owner   => xani,
        replace => no,
    }
}

class home::config::svn {
    file {'/usr/local/bin/svn-commit':
        content => template('home/svn-commit.erb'),
        owner   => xani,
        mode    => 755,
    }
    package { 'subversion':
        ensure => installed,
    }
}
