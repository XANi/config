#!/usr/bin/perl
open(DEVLIST,'-|','xinput');
while(<DEVLIST>) {
    if ($_ =~ /id=(\d+)/) {
        my $dev_id=$1;
        if ($_ =~ /pointer/ && $_ !~ /keyboard/i && $dev_id > 4) {
            system('xinput', 'set-prop', $dev_id, 'Device Accel Profile', '-1');
        }
    }
}
#xinput set-button-map 9 1 2 3 4 5 6 7 8 2
#xinput set-button-map 10 1 2 3 4 5 6 7 8 2
