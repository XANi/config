stage { 'init': before => Stage['pre'] }
stage { 'pre': before => Stage['main'] }
stage { 'post': require => Stage['main'] }
stage { 'last': require => Stage['post'] }

$location = hiera('location','default')
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
    }
	monit::monitor { dpp:; }
    file { "/tmp/i_am_puppet":
        content => "DPP: puppet ver $puppetversion on $hostname; facter ver $facterversion",
    }
}
