class env {
    $proxy_domain = hiera('proxy_in_domain',false)
    if $proxy_in_domain and $fqdn =~ /$proxy_domain/ {
        $env_content = template('env/env.erb')
    }
    else {
        $env_content = "# puppet managed file\n"
    }
    file { '/etc/environment':
        content => $env_content,
        mode    => 644,
        owner   => root,
    }
}
