define util::add_user_to_group ($user,$group) {
    exec { "add-${user}-to-group-${group}":
        command => "useradd -G ${group} ${user}",
        unless  => "id ${user} |grep -q ${group}",
    }
}
