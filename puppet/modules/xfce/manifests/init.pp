class xfce {
  package {
    ['gtk2-engines-nodoka']:
      ensure => installed
  }
  package {
      ['task-xfce-desktop']:
          ensure => installed,
  }
}

define xfce::theme {
  file { "/usr/share/themes/${title}":
    ensure  => directory,
    recurse => true,
    source  => "puppet:///modules/xfce/themes/${title}",
  }
}
