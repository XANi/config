
# in general im not a fan of cultivating old bugs
# but i like typing 4 letters instead of 8 to poweroff my machine and aliases sont work great with sudo
class systemd::poweroff_on_halt {
    file { '/lib/systemd/systemd-halt.service':
        source => '/lib/systemd/systemd-poweroff.service',
        mode   => 644,
        owner  => root,
    }
}
