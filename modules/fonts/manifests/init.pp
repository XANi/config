# Class:
#
# Parameters:
#
class fonts {
    file {'/usr/local/share/fonts/opentype':
        ensure => present,
        mode   => 644,
        recurse => true,
        source => 'puppet:///modules/fonts/otf/',
    }
}
