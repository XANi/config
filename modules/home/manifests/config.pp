class home::config (
    $gpgid = hiera('gpgid',false),
    $multiplex_ssh = hiera('multiplex_ssh', false),
) {
    include home::common
    $homedir = $home::common::homedir
    user { xani:
        ensure => present,
#        shell  => '/bin/bash',
    }
    File {
        owner => xani,
        group => xani,
    }
    $git = $home::common::git
    home::config::file {
        bash_prompt:;
        bash_functions:;
        bashrc:;
        conkyrc:;
        ctags:;
        gitconfig:;
        gitignore_global:;
        htoprc:;
        inputrc:;
        perlconsolerc:;
        screenrc:;
        toprc:;
        xsessionrc:;
        xmodmap:;
        zshrc:;
        Xresources:;
        terminator:
            target => ".config/terminator/config";
        arbtt:
            source => 'home/config/arbtt-categorize.cfg',
            target => '.arbtt/categorize.cfg';
        tilda:
            target => '.config/tilda/config_0';
#        "i3status.conf":;
        "i3blocks.conf":
            target => '.config/i3blocks/config';
        "i3-config":
            target => '.i3/config';
        "gtkrc-2.0":;
        "gtkrc-3.0":
            target => '.config/gtk-3.0/settings.ini';
        "dunstrc":
            target => '.config/dunst/dunstrc';
    }
    home::config::exec {
        git-wtf:;
        ssh-askpass-wrapper:;
        notify-wrapper:;
        puppet-notify:;
        fetch-repos:;
        testbot:;
        fetch-repos-cron:
            target => "/etc/cron.daily/fetch-repos";
        meta:;
        'i3blocks/vpn':
            target => "$homedir/.config/i3blocks/blocks/vpn";
        'i3blocks/tinymon':
            target => "$homedir/.config/i3blocks/blocks/tinymon";
        'i3blocks/network':
            target => "$homedir/.config/i3blocks/blocks/network";
    }
    home::config::code_tmp {
        erb:;
        pl:;
        pp:;
        sh:;
        mojo:;
    }
    home::dir {
        '.config':;
        '.config/i3blocks':;
        '.config/i3blocks/blocks':;
        '.config/terminator':;
        '.config/dunst':;
        '.i3':;
        '.tilda':;
        'src':;
        'src/lib':;
        'src/lib/go':;
    }

    # disable ssh's own agent, preferring GPG one
    file {'/etc/X11/Xsession.d/90x11-common_ssh-agent':
        ensure => absent,
    }

    home::config::autostart {'tilda': command => 'bash -c "echo $(sleep 20 ; tilda) &"'}
    file {'/home/xani/autostart.sh':
        mode   => 700,
        owner  => xani,
        ensure => present,
    }
    home::config::autostart {'autostart': command => 'bash -c "/home/xani/autostart.sh &"'}
    if ($location == 'arte') {
        home::config::autostart {'shutter': command => 'bash -c "echo $(sleep 60 ; shutter  --min_at_startup) &"'}
    }

    file {'xani-ssh-config-dir':
        path   => "$homedir/.ssh",
        ensure => directory,
        mode   => 700,
    }
    if $multiplex_ssh {
        file {"${homedir}/.ssh/mux":
            ensure => directory,
        }
    }

    file { 'xani-git-template':
        path   => "${homedir}/.src/git-template",
        source => "puppet:///modules/home/git-template",
    }

    file { 'xani-ssh-config':
        path    => "${homedir}/.ssh/config",
        content => template('home/config/ssh_config'),
        mode    => 600,
        require => File['xani-ssh-config-dir'],
    }
}

define home::config::file (
        $source = "home/config/${title}",
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
    $source = $title,
    $target = "/usr/local/bin/${title}",
    ) {
    file { $target:
        content => template("home/exec/${source}"),
        mode    => 755,
        owner   => xani,
    }
}

class home::config::svn {
    home::config::exec { svn-commit:; }

    package { 'subversion':
        ensure => installed,
    }
}
define home::config::autostart (
    $command,
    $description = $title,
    $comment = "Comment not defined",
    $icon = "",
    $terminal = false,
) {
    require home::common
    $homedir = $home::common::homedir
    file {"${homedir}/.config/autostart/${title}.desktop":
        content => template('home/autostart.desktop'),
        mode    => 644,
        owner   => xani,
        group   => xani,
    }
}
