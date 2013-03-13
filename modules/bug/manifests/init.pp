/*
# bug

Notify about any known bugs in current puppet version

*/

class bug {
    include bug::puppet::bug14093
}


class bug::puppet::bug14093 {
    $string = "fail"
    $testme = inline_template("<%= Time.now %>")
    if $testme == $string {
        notify{ "Bug 14093! upgrade puppet! http://projects.puppetlabs.com/issues/14093":; }
    }
}
