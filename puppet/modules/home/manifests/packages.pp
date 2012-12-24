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
         fonts-liberation,  # font for emacs
         terminator,
         # utils
         meld,
         wireshark,
         scrot,
         shutter,
         git,
         mc,
         sshfs,
         gtklp,
         cups-pdf,
         libnotify-bin,
         pkg-mozilla-archive-keyring,
         perlconsole,
         libcapture-tiny-perl,
         colordiff,
         gnome-gpg,
         seahorse,
         youtube-dl,
         xtightvncviewer,
         #dev crap
         cpanminus,
         libjson-perl,
         libyaml-perl,
         libfile-slurp-perl,
         gdb-multiarch,
         # R analysis tools
         rkward,
        ]:
            ensure => installed,

    }
}


