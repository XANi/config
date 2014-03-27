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
         ack-grep,
         colordiff,
         cups-pdf,
         eog,
         strace,
         git,
         gnupg,
         gnupg-agent,
         gtklp,
         ipcalc,
         libcapture-tiny-perl,
         libdevel-nytprof-perl,
         libnotify-bin,
         mc,
         meld,
         perlconsole,
         perltidy,
         pkg-mozilla-archive-keyring,
         pwgen,
         rlwrap,
         screen,
         scrot,
         seahorse,
         shutter,
         sshfs,
         tilda,
         tree,
         unrar,
         wireshark,
         xtightvncviewer,
         youtube-dl,
         zenity,
         zile,
         #dev crap
         carton,
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
