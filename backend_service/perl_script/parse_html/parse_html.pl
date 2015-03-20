#!/usr/bin/perl  
use strict;
use WWW::HtmlUnit;
use HTML::TableExtract;

open(OUTPUT, ">/home/junzheng_zhang/Documents/DevelopeTools/TTAutoVerify/backend_service/perl_script/parse_html/parse_html.csv") or die $!;
my @titles = ("Branch Name", "Name", "Reviewer");
print OUTPUT join(",", @titles),"\n";

undef $/;
open(HTML, 'ASUS Tool Site.html') or die $!;
my $page_local = <HTML>;
close HTML;
$/ = "\n";

my @branch_device_reviewer = &getBranchDeviceReviewer();

foreach(@branch_device_reviewer) {
        print OUTPUT $_, "\n";
}

sub getBranchDeviceReviewer() {
    my $te = HTML::TableExtract->new();
    $te->parse( $page_local);

    my @branch_device_reviewer = ();
    foreach my $ts ( $te->tables ) {
        foreach my $row ( $ts->rows ) {
            my @rs = @$row;
            if($rs[0] eq "ON") {
                $rs[1] =~ s/\n//g;
                $rs[1] =~ s/\t*//g;
                $rs[3] =~ s/\n/ & /g;
                push @branch_device_reviewer, "$rs[2],$rs[1],$rs[3]";
            };
        }
    }

    return @branch_device_reviewer;
}

close OUTPUT;
