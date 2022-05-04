define puppet::lazyfact ($val) {
    $fact = {
        $title => $val
    }
    file { "/etc/facter/facts.d/${title}.yaml":
        content => inline_template("<% YAML.dump(@fact) %>"),
        mode => "600",
        owner => "root",
    }

}
