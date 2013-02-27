

class vm {
    if $virtual == 'virtualbox' {
        package { 'virtualbox-guest-x11':
            ensure => latest,
        }
    }
}


