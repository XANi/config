class emacs ( $homedir = hiera('homedir','/home/xani'),  $deploy_portable_config = hiera('deploy_portable_config',false) ) {
    # default config
    # Theme name
    #   $emacs_theme    = 'purple-haze'
    $emacs_theme    = 'twilight-anti-bright'
    # activate rainbow-delimiters coloring, for themes that dont have it
    $rainbow = true
    $deploy_arte_config = hiera('deploy_arte_config',false)

    File {
        owner => xani,
        group => xani,
        mode  => 644,
    }
    package { emacs-snapshot:
    alias => 'emacs', # for deps
        ensure => installed,
    }

    package { [
               'lua-mode',
               'org-mode',
               'sepia', # Simple Emacs-Perl InterAction
               'twittering-mode',
               'texlive-latex-base',
               'puppet-lint',
               'yaml-mode',
#               'wl-beta',
               'bbdb',
               'wmctrl',
               'xprintidle', # mostly for jabber mode
               ]:
        ensure  => installed,
    require => Package['emacs'],
    }
    # old packages that we now get from elpa or dont use at all
    package { [
               'apel',
               'yasnippet',
               'magit',
               'emacs-jabber',
               ]:
                   ensure => absent,
    }
    $emacs_packages = [
                       'buffer-move',
                       'charmap',
                       'flymake-yaml',
                       'jabber',
                       'rainbow-mode',
                       'rainbow-delimiters',
                       'color-theme-sanityinc-tomorrow',
                       'color-theme-solarized',
                       'purple-haze-theme',
                       'tabbar',
                       'tabbar-ruler',
                       'twittering-mode',
                       'twilight-anti-bright-theme',
                       'yasnippet',
                       'zencoding-mode',
                       ]
    file { "${homedir}/emacs/install-packages.el":
        content => template('emacs/install-packages.el'),
        owner   => xani,
        group   => xani,
        notify  => Exec['refresh-emacs-packages'],
        mode    => 644,
    }

    exec { 'refresh-emacs-packages':
        command     => "/usr/bin/emacs -Q --script ${homedir}/emacs/install-packages.el",
        refreshonly => true,
        logoutput   => true,
        environment => [
                        "HOME=${homedir}",
                        ],
        user        => 'xani',
    }

    # main dirs
    file {[
           "${homedir}/emacs/autosave",
           "${homedir}/emacs/backup",
           ]:
               ensure => directory,
               mode   => 750,
    }

    file { 'run_emacs':
        path    => '/usr/local/bin/e',
        content => template('emacs/e.erb'),
        owner   => root,
        mode    => 755,
    }
#    file { 'git-emacs':
#        path    => '/usr/lib/git-core/emacs',
#        ensure  => '/usr/local/bin/e',
#    }
    file { emacs-config:
        path    => "${homedir}/.emacs-legacy",
        owner   => xani,
        group   => xani,
        mode    => 644,
        content => template('emacs/emacs.erb'),
    }
    file { emacs-config-modular:
        path    => "${homedir}/.emacs",
        owner   => xani,
        group   => xani,
        mode    => 644,
        content => template('emacs/emacs.modular.erb'),
    }
    file { emacs-wanderlust-config:
        path    => "${homedir}/.wl",
        owner   => xani,
        group   => xani,
        mode    => 600,
        content => template('emacs/emacs.wl.erb'),
    }
    file { emacs-wanderlust-folder-config:
        path    => "${homedir}/.folders",
        owner   => xani,
        group   => xani,
        mode    => 600,
        content => template('emacs/emacs.folders.erb'),
    }
    file { xani-emacs-dir:
        path   => "${homedir}/emacs",
        ensure => directory,
        purge  => true,
        force  => true,
        owner  => xani,
        group  => xani,
    }

    file { xani-emacs-test:
        path   => "${homedir}/emacs/tmplib",
        ensure => directory,
        purge  => false,
        force  => false,
        owner  => xani,
        group  => xani,
    }

    file { xani-emacs-libs:
        path    => "${homedir}/emacs/lib",
        ensure  => directory,
        source  => "puppet:///modules/emacs/emacs-libs",
        recurse => true,
        purge   => true,
        force   => true,
        ignore  => '*.elc',
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-dir'],
    }
    file {"${homedir}/emacs/xani-lib/mklib":
        mode    => 755,
    }

    file { xani-emacs-xani-libs:
        path    => "${homedir}/emacs/xani-lib",
        ensure  => directory,
        source  => "puppet:///modules/emacs/parts",
        recurse => true,
        purge   => true,
        force   => true,
        ignore  => '*.elc',
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-dir'],
    }

    file { xani-emacs-local-customisation:
        path    => "${homedir}/emacs/xani-lib/xani-local.el",
        source  => "puppet:///modules/emacs/parts/xani-local.el",
        replace => no,
        owner   => xani,
        group   => xani,
        mode    => 700,
    }

    file { xani-emacs-icons:
        path    => "${homedir}/emacs/icons",
        ensure  => directory,
        source  => "puppet:///modules/emacs/emacs-icons",
        recurse => true,
        purge   => true,
        force   => true,
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-dir'],
    }
    file { xani-emacs-autoinsert:
        path    => "${homedir}/emacs/autoinsert",
        ensure  => directory,
        recurse => true,
        purge   => true,
        force   => true,
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-dir'],
    }
    file { xani-emacs-yasnippet:
        path    => "${homedir}/emacs/yasnippet",
        ensure  => directory,
        source  => "puppet:///modules/emacs/yasnippet",
        recurse => true,
        purge   => true,
        force   => true,
        ignore  => '.yas-compiled-snippets.el',
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-dir'],
    }
    file { xani-emacs-yasnippet-custom:
        path    => "${homedir}/emacs/yasnippet/custom",
        ensure  => directory,
        recurse => false,
        purge   => false,
        force   => false,
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-yasnippet'],
    }
    # imported from other modules
    file { 'xani-emacs-yasnippet-import':
        path    => "${homedir}/emacs/yasnippet/import",
        ensure  => directory,
        recurse => true,
        purge   => true,
        force   => true,
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-yasnippet'],
    }
    emacs::autoinsert {
        'puppet':;
        'perl':;
        'perl_module':;
        'erb':;
        'sh':;
    }
    file { puppet-lint-wrapper:
        path    => '/usr/local/bin/puppet-lint-wrapper',
        mode    => 755,
        owner   => root,
        content => template('emacs/puppet-lint-wrapper.erb'),
    }
    # this have to be at end
    if $deploy_portable_config {
        $portable_config = 1
        file { emacs-config-arte:
            path    => "${homedir}/src/svn-puppet/modules/artegence/files/xani/emacs",
            owner   => xani,
            group   => xani,
            mode    => 644,
            content => template('emacs/emacs.erb'),
        }
    }

    # storage for gpg-encrypted files
    file { xani-emacs-libs-secure:
        path    => "${homedir}/emacs/secure",
        ensure  => directory,
        owner   => xani,
        group   => xani,
        mode    => 0700,
        require => File['xani-emacs-dir'],
    }
    file { xani-emacs-secure-local-config:
        path    => "${homedir}/emacs/secure/local.el.gpg",
        ensure  => present,
        mode    => 600,
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-libs-secure'],
    }

}

class emacs::org ($cron_hour = '*', $cron_minute = '*/5', $homedir = '/home/xani' ) {
    file { xani-emacs-org-share:
        path    => "${homedir}/emacs/org/share",
        ensure  => directory,
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-org'],
    }
    if $::location == 'arte' {
        file { xani-emacs-org-arte:
            path    => "${homedir}/emacs/org/arte",
            ensure  => directory,
            owner   => xani,
            group   => xani,
            require => File['xani-emacs-org'],
        }
        cron { 'xani-org-update-arte':
            command => "/home/xani/emacs/org/arte/c",
            user    => xani,
            hour    => '*',
            minute  => '*/5',
        }
        file { "${homedir}/emacs/org/cal.ics":
            ensure => "${homedir}/emacs/org/arte.ics",
        }
    }
    else {
        file { "${homedir}/emacs/org/cal.ics":
            ensure => "${homedir}/emacs/org/share.ics",
        }
    }
    file { xani-emacs-org:
        path    => "${homedir}/emacs/org",
        ensure  => directory,
        owner   => xani,
        group   => xani,
        require => File['xani-emacs-dir'],
    }

    exec { create-org-share:
        cwd       => "${homedir}/emacs/org",
        creates   => "${homedir}/emacs/org/share/.git",
        logoutput => true,
        command   => "/usr/bin/git clone ssh://git@devrandom.pl/org-todo.git $homedir/emacs/org/share",
        user      => xani,
        require   => [Package['git'], File['xani-emacs-org-share'],]
    }

    cron { 'xani-org-update':
        command => "/home/xani/emacs/org/share/c",
        user    => xani,
        hour    => $cron_hour,
        minute  => $cron_minute,
    }

    # Orage sync
    file { update-orage-calendar:
        path    => '/usr/local/bin/update-orage-calendar',
        content => template('emacs/update-orage-calendar.erb'),
        mode    => 755,
        owner   => root,
    }

    cron { 'xani-orage-update':
        command => "/usr/local/bin/update-orage-calendar",
        user    => xani,
        minute  => '*/20',
    }
}

class emacs::org::sync ( $homedir = '/home/xani' ) {
    exec { xani-emacs-mobile-org:
        command => "/bin/mkdir -p $homedir/emacs/org/mobile.org",
        user    => xani,
        creates => "${homedir}/emacs/org/mobile.org",
        require => File['xani-emacs-org'],
    }
    if ! defined (Package['sshfs'])  {
      package { sshfs: ensure => installed }
    }
    exec { mount-orgshare:
        #cwd      => "${homedir}/emacs/org",
        unless    => "/usr/bin/sudo -u xani /usr/bin/test -e $homedir/emacs/org/mobile.org/remote", # fuse works in a way that forbids root to have access to user-mounted files, so we sudo to mounting user
        logoutput => true,
        command   => $hostname ? {
            'spare2' => "/usr/bin/sudo -u xani -i /usr/bin/tsocks /usr/bin/sshfs orgmode@devrandom.eu:/home/orgmode $homedir/emacs/org/mobile.org/",
            default  => "/usr/bin/sudo -u xani -i /usr/bin/sshfs orgmode@devrandom.eu:/home/orgmode $homedir/emacs/org/mobile.org/",
        },
        require   => [Package['sshfs'], Exec['xani-emacs-mobile-org'],]
    }
}

define emacs::autoinsert {
    $homedir = hiera('homedir','/home/xani')
    file {"${homedir}/emacs/autoinsert/${title}":
        content => template("emacs/autoinsert/${title}.erb"),
        mode    => 644,
        owner   => xani,
    }
}
