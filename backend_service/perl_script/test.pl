#!/usr/bin/perl -w
use strict;

my $base_path = "/home/junzheng_zhang/Documents/DevelopeTools/TTAutoVerify/backend_service/perl_script";
open(FH, $base_path."/all_bug.csv") or die $!;
my @content = <FH>;
my @tt = $content[0] =~ /(\d{6}),/g;
#print join(", ", @tt)."\n";

foreach(@tt) {
    my $find = `git log | grep $_`;
    if($find ne "") {
        print $_."\n";
    }
}

close FH;
