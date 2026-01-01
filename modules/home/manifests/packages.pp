class home::packages {
    include home::common
    include common::utils
   stdlib::ensure_packages([
            # system
            anacron,
            # terminal
            xfonts-terminus,
            xfonts-terminus-dos,
            xfonts-terminus-oblique,
            fonts-noto, # covers most of unicode missing in rest of the fonts
            ttf-dejavu,
            terminator,
            # utils
            aspell-en,
            colordiff,
            printer-driver-cups-pdf,
            eog,
            git,
            pv,
            gnupg,
            gnupg-agent,
            gtklp,
            ipcalc,
            jq,
            libcapture-tiny-perl,
            libdevel-nytprof-perl,
            libnotify-bin,
            mc,
            meld,
            parallel,
            perlconsole,
            perltidy,
            pkg-mozilla-archive-keyring,
            pwgen,
            rlwrap,
            scrot,
            seahorse,
            scdaemon, # Yubikey smartcard
            vbindiff,
            flameshot,
            silversearcher-ag,
            sshfs,
            strace,
            tilda,
            unrar,
            wireshark,
            xscreensaver,
            qownnotes,
            xtightvncviewer,
            youtube-dl,
            zenity,
            #dev crap
            carton,
            cpanminus,
            libjson-perl,
            libyaml-perl,
            libfile-slurp-perl,
            gdb-multiarch,
            # decent pdf viewer
            okular,
            # R analysis tools
            rkward,
            # network
            hping3,
            #
            i3,
            i3blocks,
            conky,
            picom, # compositing
            feh, # wallpaper
            playerctl, # media player controls
            diodon, # clipboard manager
            rofi, # window title search, run menu
            qownnotes, # desktop wiki
            syslinux-utils, # for isohybrid
            keepassxc,
            gcalcli,
            todotxt-cli,
            qt5ct, # qt5 theme config without KDE
            qalc,  #calculator
    ])
    # for some bullshit reason a lot of packages recommend apache; fuck them
    package { 'apache2.2-common': ensure => absent }
    # epdfviewer cant even print correctly
    package { 'epdfviewer': ensure => absent }
    # another software that tries to open PDFs but fails at doing that correctly
    package { 'vprerex': ensure => absent }
    # moreutils conflicts with parallel
    package { 'moreutils': ensure => absent }
    #fork is better
    package { 'keepassx': ensure => absent }
    # polish translations are crap and/or outdated
    package {
        [
         manpages-pl,
         manpages-pl-dev,
         ]:
             ensure => absent;
    }
    # remove Useless FireWall
    package {[
        'ufw'
    ]: ensure => absent
    }
}
