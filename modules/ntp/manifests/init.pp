
class ntp::client ($server = hiera('ntp_server','pl.pool.ntp.org')) {
    package { 'ntpdate':
        ensure => installed;
    }
    file { '/etc/cron.hourly/ntpdate':
        mode  => 755,
        owner => root,
        content => "#!/bin/sh\nntpdate -t 60 $server >/dev/null 2>&1\n",
    }
}
