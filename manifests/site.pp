# defaults
stage { 'init': before => Stage['pre'] }
stage { 'pre': before => Stage['main'] }
stage { 'post': require => Stage['main'] }
stage { 'last': require => Stage['post'] }
# Apt::Source <| |>-> Exec['apt-update'] -> Package <| |>
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

schedule {'once-per-day':
    period => daily,
    repeat => 1,
}

notify {"First run of the day":
    schedule => 'once-per-day',
}

class desktop {
    realize Apt::Source['main-stable']
    realize Apt::Source['main-testing']
    realize Apt::Source['mono']
    realize Apt::Source['spotify']
    realize Apt::Source['gns3-stretch']
    realize Apt::Source['docker']
    realize Apt::Source['yarn']
    realize Apt::Source['zim']
    realize Apt::Source['asbru']
    package {'emdebian-archive-keyring':
        ensure => installed,
    }
    class {
        'core':;
        'bug':;
        'common::utils':;
        'custom':;
        'dev::haproxy':;
        'dpp':
            schedule_run => 3600,
            poll_interval => 600,
            ;
        'emacs::org':;
        'emacs':;
        'emacs::wl':;
        'env':;
        'fonts':;
        'home':;
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

    xfce::theme { 'Nodoka-Midnight-XANi':; }
    xfce::theme { 'Xfce-dusk-xani':; }
    package {'monit':
        ensure => absent
    }

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
    include core::suspend::disable
}

class desktop::efi {
    include desktop
    realize Apt::Source['nextcloud']
    realize Apt::Source['nodesource-8']
    realize Apt::Source['google-cloud-sdk']
    ensure_packages(['librt-client-rest-perl'])
    ssl::cert {'efi':;}
}

node ghroth {
    include desktop::efi
    include kanboard::server

    #     'rabbitmq':;
    #     'oracle_java':;
    #     'sysdig':;
    #    }
    include dev::rabbitmq
}

node yidhra {
    include desktop::efi
    include util::mobile::laptop
    include dota2
    include hw::vaiopro
}
node erise {
    include util::mobile::laptop
    include desktop
}
node 'vm-debian' {
    include desktop
    include emacs::wl
}
node hydra {
    include desktop
    # apt::source {
    #     "emdebian":;
    #     "bareos":;
    # }
    realize Apt::Source['google-cloud-sdk']
    include dota2
    include util::deb::pkgmaker
    include emacs::wl
    include kanboard::server
}
