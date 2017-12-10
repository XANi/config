class home::packages {
    include home::common
    if $type == "Notebook" {
        include home::packages::notebook
    }
    include common::utils
    package {
        [
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
         cups-pdf,
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
         shutter,
         silversearcher-ag,
         sshfs,
         strace,
         tilda,
         unrar,
         wireshark,
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
         compton, # compositing
         feh, # wallpaper
         parcellite, # clipboard manager
         rofi, # window title search, run menu
         arbtt,
         ]:
             ensure => installed,

    }
    # for some bullshit reason a lot of packages recommend apache; fuck them
    package { 'apache2.2-common': ensure => absent }
    # epdfviewer cant even print correctly
    package { 'epdfviewer': ensure => absent }
    # another software that tries to open PDFs but fails at doing that correctly
    package { 'vprerex': ensure => absent }
    # moreutils conflicts with parallel
    package { 'moreutils': ensure => absent }
    # polish translations are crap and/or outdated
    package {
        [
         manpages-pl,
         manpages-pl-dev,
         ]:
             ensure => absent;
    }
}

class home::packages::notebook {
    package {[
              'xbacklight'
              ]:
                  ensure => installed,
    }
}
