class env {
    $proxy_domain = lookup('proxy_domain',undef,undef,false)
    $proxy = lookup('proxy',undef,undef,false)
    $no_proxy = lookup('no_proxy',undef,undef,false)
    notify {"Proxy_domain: ${proxy_domain}, proxy ${proxy}":;}
    if $proxy_domain and $::domain == $proxy_domain and $proxy {
        $env_content = template('env/env.erb')
    }
    else {
        $env_content = "# puppet managed file\n"
    }
    file { '/etc/environment':
        content => $env_content,
        mode    => "644",
        owner   => root,
    }
}
