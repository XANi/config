class home::packages {
    include home::common
    package {
        [
         # system
         anacron,
         # terminal
         xfonts-terminus,
         xfonts-terminus-dos,
         xfonts-terminus-oblique,
         ttf-dejavu,
         terminator,
         # utils
         unrar,
         zile,
         ipcalc,
         meld,
         wireshark,
         scrot,
         screen,
         shutter,
         git,
         pwgen,
         mc,
         sshfs,
         gtklp,
         rlwrap,
         cups-pdf,
         libnotify-bin,
         pkg-mozilla-archive-keyring,
         perlconsole,
         perltidy,
         libcapture-tiny-perl,
         libdevel-nytprof-perl,
         colordiff,
         gnome-gpg,
         seahorse,
         youtube-dl,
         xtightvncviewer,
         eog,
         zenity,
         tilda,
         #dev crap
         cpanminus,
         libjson-perl,
         libyaml-perl,
         libfile-slurp-perl,
         gdb-multiarch,
         # decent pdf viewer
         evince,
         # R analysis tools
         rkward,
         #
         arbtt,
         ]:
             ensure => installed,

    }
    # for some bullshit reason a lot of packages recommend apache; fuck them
    package { 'apache2.2-common':
        ensure => absent,
    }
    # epdfviewer cant even print correctly
    package { 'epdfviewer':
        ensure => absent,
    }
    # polish translations are crap and/or outdated
    package {
        [
         manpages-pl,
         manpages-pl-dev,
         ]:
             ensure => absent;
    }
}


