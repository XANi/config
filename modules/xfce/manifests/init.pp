class xfce {
  
}

define xfce::theme {
  file { "/usr/share/themes/${title}":
    ensure  => directory,
    recurse => true,
    source  => "puppet:///modules/xfce/themes/${title}",
  }
}
