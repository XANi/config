class home::mime::common {
    include home::common
    concat { '/usr/share/applications/mimeapps.list':
        owner => "root",
    }
    concat::fragment { "mime-header":
        order => "0000",
        content => "# puppet managed\n\n[Default Applications]\n",
        target => '/usr/share/applications/mimeapps.list',
    }



}
define home::mime(
    $type = $title,
    $app,
)   {
    concat::fragment { "mime-${title}":
        order => "1000",
        target  => '/usr/share/applications/mimeapps.list',
        content => inline_template("${type}:${app}.desktop\n")
    }
}