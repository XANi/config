class home::mime::common {
    include home::common
    concat { '/usr/share/applications/defaults.list':
        owner => "root",
    }
    concat::fragment { "mime-header":
        order => "0000",
        content => "# puppet managed\n\n[Default Applications]\n",
        target => '/usr/share/applications/defaults.list',
    }



}
define home::mime(
    $type = $title,
    $app,
)   {
    include home::mime::common
    concat::fragment { "mime-${title}":
        order => "1000",
        target  => '/usr/share/applications/defaults.list',
        content => inline_template("${type}=${app}.desktop\n")
    }
}
