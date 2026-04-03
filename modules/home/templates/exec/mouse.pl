#!/usr/bin/perl
use v5.40;
use strict;
open(my $xi,'-|','xinput','list','--short') or die ($!);
my $device_to_find ="Logitech G500s Laser Gaming Mouse";
my $prop_to_find ='libinput Accel Speed';
my $in_pointer=0;
my $device_id=0;
while(my $line=<$xi>) {
    my @v = split(/\t+/,$line);
    #say join("-|-",@v);
    if ($v[0] =~ /Virtual core pointer/) {
        $in_pointer = 1;
    } elsif ($v[0] =~ /Virtual core keyboard/) {
        $in_pointer = 0;
    } else {
        if ($in_pointer == 0) {
            next
        }
        my $name = $v[0];
        $name =~ s/^.+?([a-zA-Z0-9]+.*)/$1/;
        $name =~ s/^\s+//;
        $name =~ s/\s+$//;
        #say "-- $name --";
        if ($name eq $device_to_find) {
            $v[1] =~ m/id=(\d+)/;
            $device_id = $1;
            last
        }
    }
}
close($xi);

if ($device_id == 0) {
    say "couldn't find $device_to_find device";
    exit(1)
}

say "Device ID: $device_id";

open($xi,'-|','xinput','list-props',$device_id) or die ($!);
my $prop_id=0;
while(my $line=<$xi>) {
    if ($line =~ /\s+(.+) \((\d+)\):.*/) {
        if ($1 eq $prop_to_find) {
            $prop_id = $2
        }
    }
}
if ($prop_id == 0) {
    say "could not find prop $prop_to_find in device $device_id";
    exit 1;
}
my @cmd = qq(xinput set-prop $device_id $prop_id -1);
say "running " . join(" ", @cmd);
system(@cmd);