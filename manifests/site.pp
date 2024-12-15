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

$location = lookup('location',undef,undef,'default')
$project = lookup('project',undef,undef,'default')
$puppet_header = "DPP/Puppet managed file at location $location, DO NOT EDIT BY HAND, changes will be overwritten."

schedule {'once-per-day':
    period => daily,
    repeat => 1,
}

notify {"First run of the day":
    schedule => 'once-per-day',
}

class desktop {
    realize Apt::Source['mono']
    realize Apt::Source['spotify']
    realize Apt::Source['gns3-stretch']
    realize Apt::Source['docker']
    realize Apt::Source['qownnotes']
    realize Apt::Source['asbru']
    realize Apt::Source['signal']
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
    # else vscode opens dirs
    file {'/usr/share/applications/code.desktop':
        ensure => absent
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
    file { [
        '/home/xani/.cache/.nobackup',
        '/home/xani/.config/google-chrome/.nobackup',
        '/home/xani/go/.nobackup',
        '/home/xani/.mozilla/.nobackup',
        '/home/xani/.gradle/.nobackup',
        '/home/xani/.cargo/.nobackup',
        #'/home/xani/.debug/.nobackup',
        '/home/xani/.rustup/.nobackup',
    ]:
        content => "# this file makes bareos exclude directory it is in | puppet\n*\n",
        owner => 'xani',
    }
}

class desktop::efi {
    include desktop
#    realize Apt::Source['google-cloud-sdk']
    ensure_packages(['librt-client-rest-perl'])
    ssl::cert {'efi':;}
}

node ghroth {
    include desktop::efi
    include custom::work
    include kanboard::server
    include dev::rabbitmq
}

node yidhra,'yidhra.home.zxz.li' {
    include desktop::efi
    include custom::work
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
    include custom::work
    realize Apt::Source['main-trixie']
    # apt::source {
    #     "emdebian":;
    #     "bareos":;
    # }
    realize Apt::Source['google-cloud-sdk']
    include dota2
    include util::deb::pkgmaker
    include emacs::wl
    include bareos::fd
    include kanboard::server
    include collectd::client
    include collectd::plugin::turbostat
    include collectd::ssd
    file { '/etc/sensors.d/disable_bad_temp':
        content => '
chip "it8620-isa-0a30"
  ignore temp2
  ignore fan3
  ignore fan4
  ignore fan5
  ignore cpu0_vid
chip "acpitz-acpi-0"
  ignore temp1
  ignore temp2
',
        notify => Service['collectd'],
    }
    collectd::plugin::perl {'PSI':;}
    class { 'restic::backup::common':
        backup_check => false,
    }
    restic::backup::file { 'root':
        directory => "/",
        exclude_set => 'system',
    }
    restic::exclude::set { 'system':
        exclude_set => [
            '/dev',
            '/var/lib/bacula',
            '/proc',
            '/tmp',
            '/var/tmp',
            '/.journal',
            '/.fsck',
            '/mnt',
            '/media',
            '/var/music',
            '/var/torrent',
            '/var/xani',
            '/var/cache',
            '/var/steam',
            '/home',
            '/run',
            '/sys',
            '/dev',
            '/var/lib/bareos',
            '/var/lib/libvirt/images',
            '/var/lib/docker',
            # removeme
            '/usr',
        ]
    }
}

