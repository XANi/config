class home::vars (
    $homedir              = hiera('homedir','/home/xani'),
    $http_proxy           = hiera('http_proxy',false),
    $https_proxy          = hiera('https_proxy',false),
    $socks_proxy          = hiera('socks_proxy',false),
    $no_proxy             = hiera('no_proxy',false),
    $perl5lib             = hiera('perl5lib',false),
    $git                  = hiera_hash('git'),
    $xrandr_left          = hiera('xrandr_left',"DVI-D-0"),
    $xrandr_right         = hiera('xrandr_right',"HDMI-0"),
    $i3_composite         = hiera('i3_composite',true),
    $i3_composite_backend = hiera('i3_composite_backend','glx'),
    $gpgid                = hiera('gpgid'),
    $conky_xinerama_head  = hiera('conky_xinerama_head',false),
    ) {}
