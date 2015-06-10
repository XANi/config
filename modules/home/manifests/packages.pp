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
         ncdu,
         meld,
         perlconsole,
         perltidy,
         pkg-mozilla-archive-keyring,
         pwgen,
         rlwrap,
         scrot,
         seahorse,
         shutter,
         sshfs,
         tilda,
         unrar,
         wireshark,
         xtightvncviewer,
         youtube-dl,
         zenity,
         aspell-en,
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
         # network
         hping3,
         #
         i3,
         i3blocks,
         compton, # compositing
         feh, # wallpaper
         parcellite, # clipboard manager
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
