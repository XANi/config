define xfce::theme {
  file { "/usr/share/themes/${title}":
    ensure => directory,
    recurse => true,
    source "$modules/xfce/files/themes/${title},
  }
}
