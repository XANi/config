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
    realize Apt::Source['spotify']
    realize Apt::Source['qownnotes']
    realize Apt::Source['asbru']
    realize Apt::Source['signal']
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
    # nextcloud client is actual fucking trash and will auto start any time file manager opens and bother user after losing auth again
    file { [
        '/usr/share/dbus-1/services/com.nextcloudgmbh.Nextcloud.service',
        #        '/usr/lib/x86_64-linux-gnu/qt6/plugins/nextcloudsync_vfs_suffix.so',
        #        '/usr/lib/x86_64-linux-gnu/qt6/plugins/nextcloudsync_vfs_xattr.so',
    ]:
        ensure => absent,
        backup => false,
        force => true
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
        '/home/xani/src/os/.nobackup',
    ]:
        content => "# this file makes bareos exclude directory it is in | puppet\n*\n",
        owner => 'xani',
    }
}

class desktop::efi {
    include desktop
#    realize Apt::Source['google-cloud-sdk']
    stdlib::ensure_packages(['librt-client-rest-perl'])
    ensure_packages([
        'thunderbird'
    ])
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

node brigid,'brigid.home.zxz.li','brigid.non.3dart.com' {
    include desktop::efi
    include custom::work
    include util::mobile::laptop
    include collectd::client
    include collectd::plugin::turbostat
    include collectd::ssd
    include lvautoresize
    collectd::plugin::perl {'PSI':;}

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
#    realize Apt::Source['main-trixie']
    # apt::source {
    #     "emdebian":;
    #     "bareos":;
    # }
    realize Apt::Source['google-cloud-sdk']
    realize Apt::Source['microsoft']
    realize Apt::Source['main-testing']
    realize Apt::Source['firefox']
    include dota2
    include util::deb::pkgmaker
    include emacs::wl
    include kanboard::server
    include collectd::client
    include collectd::plugin::turbostat
    include collectd::ssd
    include collectd::amdgpu
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
        at_boot => true,
        dir => "/",
        exclude_set => 'root',
    }
    restic::exclude::set { 'root':
        exclude => [
            '/.journal',
            '/.fsck',
            '/dev',
            '/run',
            '/sys',
            '/proc',
            '/tmp',
            '/var/tmp',
            '/var/lib/bacula',
            '/mnt',
            '/media',
            '/home/other',
            '/var/music',
            '/var/torrent',
            '/var/xani',
            '/var/cache',
            '/var/steam',
            '/var/lib/bareos',
            '/var/lib/libvirt/images',
            '/var/lib/docker',
            '/home/xani/.ollama',
            '/usr/share/kicad/3dmodels',
            '/home/xani/sync/cloudshare',
            # rust stuff
            'target/release/deps/**',
            'target/debug/deps/**',
        ]
    }
    host {
        "s3.cthulhu.home.zxz.li": ip => "10.66.1.2";
    }
}

