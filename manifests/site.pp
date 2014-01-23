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
        'emdebian':;
        'main-testing':;
    }
    package {'emdebian-archive-keyring':
        ensure => installed,
    }
    class {
        apt::update:;
        bug:;
        custom:;
        dpp:;
        emacs::org::sync:;
        emacs::org:;
        emacs:;
        env:;
        home:;
        monit:;
        ntp::client:;
        puppet:;
        token:;
        util::etckeeper:;
        util::generic:;
        xfce:;
    }

    monit::monitor { dpp:; }
    xfce::theme { 'Nodoka-Midnight-XANi':; }


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
    }
}
node 'vm-debian' inherits default {
    include emacs::wl
}
node hydra inherits default {
    include emacs::wl
}
