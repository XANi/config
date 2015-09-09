# defaults
stage { 'init': before => Stage['pre'] }
stage { 'pre': before => Stage['main'] }
stage { 'post': require => Stage['main'] }
stage { 'last': require => Stage['post'] }
Apt::Source <| |>-> Exec['apt-update'] -> Package <| |>
Exec {
      path => [
               '/sbin',
               '/bin',
               '/usr/sbin',
               '/usr/bin',
               '/usr/local/sbin',
               '/usr/local/bin',
               ],
}

$location = hiera('location','default')
$project = hiera('project','default')
$puppet_header = "DPP/Puppet managed file at location $location, DO NOT EDIT BY HAND, changes will be overwritten."

node default {
    apt::source {
        'chromium':;
        'firefox':;
        'spotify':;
        'dropbox':;
#        'emdebian':;
        'main-testing':;
#        'bareos':;
    }
    package {'emdebian-archive-keyring':
        ensure => installed,
    }
    class {
        'apt::update':;
        'bug':;
        'common::utils':;
        'custom':;
        'dev::haproxy':;
        'dpp':;
        'emacs::org':;
        'emacs':;
        'emacs::wl':;
        'env':;
        'fonts':;
        'home':;
        'monit':;
        'motd':;
        'ntp::client':;
        'systemd::poweroff_on_halt':;
        'puppet':;
        'token':;
        'util::generic':;
        'util::fuse':;
        'xfce':;
        'zsh':;
    }

    syncthing::instance {'xani':;}

    monit::monitor { dpp:; }
    xfce::theme { 'Nodoka-Midnight-XANi':; }
    xfce::theme { 'Xfce-dusk-xani':; }


    if $is_virtual == 'true' {
        include vm
    }
    else {
        # most likely wont use spotify as music player
        package {'spotify-client':
            ensure => installed;
        }
    }

    file { "/tmp/i_am_puppet":
        content => "DPP: puppet ver $puppetversion on $hostname; facter ver $facterversion",
    }
    ssl::cert {'devrandom':;}
    # disable things that might be installed for tools but autostart service
    util::service_disable {
        'apache2':;
        'elasticsearch':;
        'jetty':;
        'jetty8':;
        'mcollective':;
        'ntop':;
        'openhpid':;
        'prosody':;
        'saned':;
        'stunnel4':;
        'sysstat':;
        'ulogd':;
        'varnishlog':;
        'varnishncsa':;
        'watchdog':;
        'wd_keepalive':;
    }
}

node efi inherits default {
    ssl::cert {'arte':;}
}

node ghroth inherits efi {
    apt::source {
        'rabbitmq':;
        'oracle_java':;
        'elasticsearch09':;
    }
    package {['oracle-java7-installer','oracle-java7-set-default']:
        ensure => installed,
    }
    # bot development
    service {'prosody':
        ensure => running,
    }
    package {'prosody':
        ensure => installed,
    }
    include dev::rabbitmq
}

node yidhra inherits efi {
    include util::mobile::laptop
    include dota2
    include hw::vaiopro
}
node 'vm-debian' inherits default {
    include emacs::wl
}
node hydra inherits default {
    apt::source {
        "emdebian":;
        "bareos":;
    }
    include dota2
    include util::deb::pkgmaker
    include emacs::wl
}
