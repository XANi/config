class zsh {
    vcsrepo {'/home/xani/.oh-my-zsh':
        ensure => present,
        provider => 'git',
        source   => 'https://github.com/robbyrussell/oh-my-zsh.git',
        user     => 'xani'
    }
    include zsh::common
}


class zsh::common {
    package {'zsh':
        ensure => installed,
    }
}
