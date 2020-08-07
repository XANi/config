class home::mime::common {
    include home::common
    concat { '/home/xani/.local/share/applications/mimeapps.list':
        owner => "xani",
        group => "xani",
    }
    concat::fragment { "xani-mime-header":
        order => "0000",
        target => '/home/xani/.local/share/applications/mimeapps.list',
    }



}
define home::mime(
    $type = $title,
    $app,
)   {
    concat::fragment { "xani-mime-${title}":
        order => "1000",
        target  => '/home/xani/.local/share/applications/mimeapps.list',
        content => inline_template("${type}:${app}.desktop\n")
    }
}