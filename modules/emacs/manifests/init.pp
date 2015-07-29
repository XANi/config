class emacs ( $homedir = hiera('homedir','/home/xani'),  $deploy_portable_config = hiera('deploy_portable_config',false) ) {
    # default config
    # Theme name
    #   $emacs_theme    = 'purple-haze'
    $emacs_theme    = 'twilight-anti-bright'
    $emacs_version  = 'emacs24'
    # activate rainbow-delimiters coloring, for themes that dont have it
    $rainbow = true
    $deploy_arte_config = hiera('deploy_arte_config',false)
    class { 'emacs::install':
        version => $emacs_version,
    }
    File {
        owner => xani,
        group => xani,
        mode  => 644,
    }
    package { [
               'bbdb',
               'exuberant-ctags',
               'puppet-lint',
               'sepia', # Simple Emacs-Perl InterAction
               'texlive-latex-base',
               'twittering-mode',
               'wmctrl',
               'xprintidle', # mostly for jabber mode
               'shellcheck', # sh lint
               'yaml-mode',
               'nethack-el',
#               'wl-beta',
               ]:
        ensure  => installed,
    require => Package['emacs'],
    }
    # old packages that we now get from elpa or dont use at all
    package { [
               'org-mode',
               'apel',
               'yasnippet',
               'magit',
               'emacs-jabber',
               'lua-mode',
               'e2wm',
               ]:
                   ensure => absent,
    }

    $emacs_packages = [
                       # 'puppet-mode', # provided in puppet repo
                       'buffer-move',
                       'charmap',
                       'cider',
                       'clojure-cheatsheet',
                       'clojure-mode',
                       'clojure-snippets',
                       'color-theme-sanityinc-tomorrow',
                       'color-theme-solarized',
                       'company',
                       'company-go',
                       'diminish',
                       'ecb',
                       'flycheck',
                       'flycheck-tip',
                       'go-mode',
                       'god-mode',
                       'haskell-mode',
                       'httprepl',
                       'ido-better-flex',
                       'ido-ubiquitous',
                       'ido-vertical-mode',
                       'iedit',
                       'impatient-mode',
                       'inf-ruby',
                       'jabber',
                       'js2-mode',
                       'json-mode',
                       'lua-mode',
                       'magit',
                       'markdown-mode',
                       'mediawiki',
                       'minimap',
                       'mouse+',
                       'move-text',
                       'multiple-cursors',
                       'nodejs-repl',
                       'nyan-mode',
                       'nyan-prompt',
                       'org',
                       'org-pandoc',
                       'org-trello',
                       'org2blog',
                       'phi-search',
                       'phi-search-mc',
                       'puppet-mode',
                       'purple-haze-theme',
                       'rainbow-blocks',
                       'rainbow-delimiters',
                       'rainbow-mode',
                       'restclient',
                       'rpm-spec-mode',
                       'shift-text',
                       'sml-modeline',
                       'tabbar',
                       'tabbar-ruler',
                       'textile-mode',
                       'twilight-anti-bright-theme',
                       'twittering-mode',
                       'undo-tree',
                       'vcl-mode',
                       'web-mode',
                       'yasnippet',
                       'zenburn-theme',
                       'zencoding-mode',
                       ]
    file { "${homedir}/emacs/install-packages.el":
        content => template('emacs/install-packages.el'),
        owner   => xani,
        group   => xani,
        notify  => Exec['refresh-emacs-packages'],
        mode    => 644,
    }
    file { "${homedir}/.emacs.d/.gitignore":
        content => template('emacs/emacs.d.gitignore'),
        mode    => 644,
    }
    file { "${homedir}/emacs/install-packages.sh":
        content => template('emacs/install-packages.sh'),
        mode    => 755,
        require => File["${homedir}/.emacs.d/.gitignore"],
    }

    exec { "create-emacs-packages":
    command     => "${homedir}/emacs/install-packages.sh && touch /tmp/emacs-install-done",
    logoutput   => true,
    creates     => "/tmp/emacs-install-done",
        environment => [
                        "HOME=${homedir}",
                        ],
        user        => 'xani',
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
        content => template('emacs/e'),
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
        content => template('emacs/emacs.legacy.el'),
    }
    file { emacs-config-modular:
        path    => "${homedir}/.emacs",
        owner   => xani,
        group   => xani,
        mode    => 644,
        content => template('emacs/emacs.modular.el'),
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
        'puppet.pp':;
        'perl.pl':;
        'perl.pm':;
        'erb':;
        'sh':;
    }
    file { puppet-lint-wrapper:
        path    => '/usr/local/bin/puppet-lint-wrapper',
        mode    => 755,
        owner   => root,
        content => template('emacs/puppet-lint-wrapper'),
    }
    # this have to be at end
    if $deploy_portable_config {
        $portable_config = 1
        file { emacs-config-arte:
            path    => "${homedir}/src/svn-puppet/modules/artegence/files/xani/emacs",
            owner   => xani,
            group   => xani,
            mode    => 644,
            content => template('emacs/emacs.legacy.el'),
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
    $deploy_arte_config = hiera('deploy_arte_config',false)
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
            minute  => '*/30',
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
        content => template('emacs/update-orage-calendar'),
        mode    => 755,
        owner   => root,
    }
    file { update-ical:
        path    => "${homedir}/emacs/ical-export.el",
        content => template('emacs/ical-export.el'),
        owner  => xani,
        group  => xani,
    }
    cron { 'xani-orage-update':
        command => "/usr/local/bin/update-orage-calendar",
        user    => xani,
        minute  => '*/5',
    }
}

define emacs::autoinsert {
    $homedir = hiera('homedir','/home/xani')
    file {"${homedir}/emacs/autoinsert/${title}":
        content => template("emacs/autoinsert/${title}"),
        mode    => 644,
        owner   => xani,
    }
}


class emacs::wl {
    require emacs
    $homedir = $emacs::homedir
    $mail_domain = hiera('wl_mail_domain','devrandom.pl')
    $mail_from = hiera('wl_mail_from')
    $mail_smtp_server = hiera('wl_smtp_server','imap.gmail.com')
    $mail_imap_server = hiera('wl_imap_server','smtp.gmail.com')
    $mail_user = hiera('wl_mail_user',false)
    $mail_smtp_user = hiera('wl_smtp_user',$mail_user)
    $mail_address_list = hiera('wl_mail_address_list',false)
    file { emacs-wanderlust-config:
        path    => "${homedir}/.wl",
        owner   => xani,
        group   => xani,
        mode    => 600,
        content => template('emacs/emacs.wl.el'),
    }
    file { emacs-wanderlust-folder-config:
        path    => "${homedir}/.folders",
        owner   => xani,
        group   => xani,
        mode    => 600,
        content => template('emacs/emacs.folders'),
    }

}


class emacs::install ($version = 'emacs-snapshot') {
    if ($version =~ /snapshot/) {
        $alternative = $version
        apt::source {'emacs-snapshot':;}
    } else {
        $alternative = "${version}-x"
    }
    package { $version:
        alias  => 'emacs', # for deps
        ensure => installed,
    }
    util::update_alternatives {
        emacs:
            target  => "/usr/bin/${alternative}",
            require => Package[$version];
        emacsclient:
            target  => "/usr/bin/emacsclient.${version}",
            require => Package[$version];
    }
    if $version =~ /emacs24/ {
        file {'/usr/share/emacs/24.3/lisp/org/':
            ensure => absent,
            force  => true,
        }
    }
}
