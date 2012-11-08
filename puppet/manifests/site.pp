stage { 'init': before => Stage['pre'] }
stage { 'pre': before => Stage['main'] }
stage { 'post': require => Stage['main'] }
stage { 'last': require => Stage['post'] }

$location = hiera('location','default')

# TODO fix it in some other way
$modules = '/var/lib/dpp/repos/shared/puppet/modules'
$puppet_header = "DPP/Puppet managed file at location $location, DO NOT EDIT BY HAND, changes will be overwritten."

node default {
    class {'apt::source': stage => init}
    $deploy_arte_config = false
    class {
        puppet:;
        apt::update:;
        dpp:;
        monit:;
        emacs:;
        emacs::org:;
        emacs::org::sync:;
        home::configs:;
    }
    monit::monitor { dpp:; }
    xfce::theme { 'Nodoka-Midnight-XANi':; }
    file { "/tmp/i_am_puppet":
        content => "DPP: puppet ver $puppetversion on $hostname; facter ver $facterversion",
    }
}
