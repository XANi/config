class home::tweaks {
    # nobody wants you imagemagick, fuck off, you are not a real image viewer
    file {[
           '/usr/share/applications/display-im6.q16.desktop',
           '/usr/share/applications/display-im6.desktop',
           ]:
               ensure => absent
    }
}
