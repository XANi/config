
class syncthing  {
    apt::source {
        'syncthing':;
    }
    package {'syncthing':
        ensure => 'latest';
    }
}


define syncthing::instance {
    include syncthing::instance
    file {"/etc/systemd/system/syncthing-${title}":
        content => template('syncthing/systemd'),
        mode => 644,
    }
    service {"syncthing-${title}":
        enable => true,
    }
}
