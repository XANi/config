if !defined($lsbdistcodename) {
    $lsbdistcodename = $os['distro']['codename']
}
if !defined($fqdn) {
    $fqdn = $networking['fqdn']
}
if !defined($hostname) {
    $hostname = $networking['hostname']
}
