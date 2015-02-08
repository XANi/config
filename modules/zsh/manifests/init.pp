class zsh {
    vcsrepo {'/home/xani/.oh-my-zsh':
        ensure => present,
        provider => 'git',
        source   => 'https://github.com/robbyrussell/oh-my-zsh.git',
        user     => 'xani'
    }
    file {'/home/xani/.oh-my-zsh/themes/xani.zsh-theme':
        content => template('zsh/xani.zsh-theme'),
        owner   => xani,
        group   => xani,
        mode    => 644,
    }
    include zsh::common
}


class zsh::common {
    package {'zsh':
        ensure => installed,
    }
}
