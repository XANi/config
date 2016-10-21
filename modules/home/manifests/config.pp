class home::config (
    $multiplex_ssh = hiera('multiplex_ssh', false),
) {
    include home::common
    require home::vars
    $homedir = $home::common::homedir
    user { xani:
        ensure => present,
#        shell  => '/bin/bash',
    }
    File {
        owner => xani,
        group => xani,
    }

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
        "tmux.conf":;
        xsessionrc:;
        xmodmap:;
        zile:;
        zshrc:;
        "Xresources":;
        ssh_config:
            target => '.ssh/config';
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
        rtm-gui:;
        ssh-askpass-wrapper:;
        notify-wrapper:;
        puppet-notify:;
        fetch-repos:;
        from-template:;
        testbot:;
        gpg-pinentry:;
        wd:;
        mouse-acc-fix:;
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
        mode   => "700",
        owner  => xani,
        ensure => present,
    }
    home::config::autostart {'autostart': command => 'bash -c "/home/xani/autostart.sh &"'}
    if ($location == 'arte') {
        home::config::autostart {'shutter': command => 'bash -c "echo $(sleep 60 ; shutter  --min_at_startup) &"'}
    }

    file {'xani-ssh-config-dir':
        path   => "${homedir}/.ssh",
        ensure => directory,
        mode   => "700",
    }
    if $multiplex_ssh {
        file {"${homedir}/.ssh/mux":
            ensure => directory,
        }
    }
    file { '/usr/share/git-core/templates/hooks/post-checkout':
        content => template('home/git/post-checkout'),
        mode    => "755",
    }
    logrotate::rule {'arbtt-xani':
        path => '/home/xani/.arbtt/capture.log',
        rotate => 24,
        rotate_every => 'month',
        minsize => '20M',
        compress => false,
        maxsize => '200M',
        prerotate => '/usr/bin/killall arbtt-capture',
    }
}




define home::config::file (
        $source = "home/config/${title}",
        $target = ".${title}",
        $mode   = "644",
    ) {
    require home::vars
    $xrandr_left          = $home::vars::xrandr_left
    $xrandr_right         = $home::vars::xrandr_right
    $git                  = $home::vars::git
    $gpgid                = $home::vars::gpgid
    $homedir              = $home::vars::homedir
    $perl5lib             = $home::vars::perl5lib
    $http_proxy           = $home::vars::http_proxy
    $https_proxy          = $home::vars::https_proxy
    $socks_proxy          = $home::vars::socks_proxy
    $no_proxy             = $home::vars::no_proxy
    $conky_xinerama_head  = $home::vars::conky_xinerama_head
#    $     = $home::vars::
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
        mode    => "755",
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
        mode    => "755",
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
    require home::vars
    $homedir = $home::vars::homedir
    file {"${homedir}/.config/autostart/${title}.desktop":
        content => template('home/autostart.desktop'),
        mode    => "644",
        owner   => xani,
        group   => xani,
    }
}
