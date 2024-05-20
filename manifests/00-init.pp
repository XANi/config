if !$lsbdistcodename {
    $lsbdistcodename = $os['distro']['codename']
}
if !$fqdn {
    $fqdn = $networking['fqdn']
}
if !$hostname {
    $hostname = $networking['hostname']
}
