class home::config ( $gpgid = hiera('gpgid',false) ) {
    include home::common
    $homedir = $home::common::homedir
    user { xani:
        ensure => present,
        shell  => '/bin/bash',
    }
    home::config::file {
        bash_prompt:;
        bashrc:;
        gitconfig:;
        htoprc:;
        inputrc:;
        perlconsolerc:;
        screenrc:;
        toprc:;
        xsessionrc:;
        terminator:
            target => "${homedir}/.config/terminator/config";
    }
    home::config::exec {
        git-wtf:;
    }
    home::config::code_tmp {
        erb:;
        pl:;
        pp:;
        sh:;
        mojo:;
    }
    home::dir {
        '.config':;,
        '.config/terminator':;,
        '.config/terminator/config':;,
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

define home::config::exec (
    $source = "home/exec/${title}.erb",
    $target = "/usr/local/bin/${title}",
    ) {
    file { $target:
        content => template($source),
        mode    => 755,
        owner   => xani,
        replace => no,
    }
}

class home::config::svn {
    home::config::exec { svn-commit:; }

    package { 'subversion':
        ensure => installed,
    }
}

