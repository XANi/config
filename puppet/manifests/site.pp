# defaults
stage { 'init': before => Stage['pre'] }
stage { 'pre': before => Stage['main'] }
stage { 'post': require => Stage['main'] }
stage { 'last': require => Stage['post'] }

Exec {
      path => [
               '/sbin',
               '/bin',
               '/usr/sbin',
               '/usr/bin',
               '/usr/local/sbin',
               '/usr/local/bin',
               ],
}

$location = hiera('location','default')
$puppet_header = "DPP/Puppet managed file at location $location, DO NOT EDIT BY HAND, changes will be overwritten."

node default {
    class {'apt::source': stage => init}
    $deploy_arte_config = false
    class {
        home:;
        puppet:;
        apt::update:;
        dpp:;
        monit:;
        ntp::client:;
        emacs:;
        emacs::org:;
        emacs::org::sync:;
        xfce:;
        token:;
        custom:;
    }
    monit::monitor { dpp:; }
    xfce::theme { 'Nodoka-Midnight-XANi':; }

    if $is_virtual {
        include vm
    }

    file { "/tmp/i_am_puppet":
        content => "DPP: puppet ver $puppetversion on $hostname; facter ver $facterversion",
    }

}

node spare2 inherits default {
    include home::config::svn
}
