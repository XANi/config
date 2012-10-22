stage { 'init': before => Stage['pre'] }
stage { 'pre': before => Stage['main'] }
stage { 'post': require => Stage['main'] }
stage { 'last': require => Stage['post'] }

node default {
    class {'apt::source': stage => init}
    $deploy_arte_config = false
    class {
        puppet:;
        apt::update:;
    }
    file { "/tmp/i_am_puppet":
        content => "DPP: puppet ver $puppetversion on $hostname; facter ver $facterversion",
    }
}
