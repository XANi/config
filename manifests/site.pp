# defaults
stage { 'init': before => Stage['pre'] }
stage { 'pre': before => Stage['main'] }
stage { 'post': require => Stage['main'] }
stage { 'last': require => Stage['post'] }
 Apt::Source <| |> -> Package <| |>
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
$puppet_header = "DPP/Puppet managed file at location $location, DO NOT EDIT BY HAND, changes will be overwritten."

node default {
    apt::source {
        'chromium':;
        'firefox':;
        'spotify':;
        'dropbox':;
        'emdebian':;

    }
    class {
        bug:;
        home:;
        puppet:;
        apt::update:;
        dpp:;
        monit:;
        ntp::client:;
        emacs:;
        emacs::org:;
        emacs::org::sync:;
        util::generic:;
        xfce:;
        token:;
        custom:;
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
}

node efi inherits default {
    ssl::cert {'arte':;}

}

node ghroth inherits efi {
    apt::source {
        'rabbitmq':;
    }
}
node vm-debian inherits default {
    include emacs::wl
    apt::source {
        'main-testing':;
    }
}
node hydra inherits default {
    include emacs::wl
}
