class env {
    $proxy_domain = hiera('proxy_domain',false)
    $proxy = hiera('proxy',false)
    $no_proxy = hiera('no_proxy',false)
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
