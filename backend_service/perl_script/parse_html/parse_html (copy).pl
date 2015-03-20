#!/usr/bin/perl  
use strict;
use WWW::HtmlUnit;
use HTML::TableExtract;

open(OUTPUT, ">/home/junzheng_zhang/Documents/DevelopeTools/TTAutoVerify/backend_service/perl_script/parse_html/parse_html.csv") or die $!;
my @titles = ("Branch Name", "Name", "Reviewer");
print OUTPUT join(",", @titles),"\n";

my $url  = "http://10.78.24.12/branchinfo/branchinfo_rec.html";

my $username = "junzheng_zhang";
my $password = "!a159357";

my $webClient           = WWW::HtmlUnit->new;
my $credentialsProvider = $webClient->getCredentialsProvider;
$credentialsProvider->addCredentials( $username, $password );
my $page = $webClient->getPage($url);

my @branch_device_reviewer = &getBranchDeviceReviewer();

foreach(@branch_device_reviewer) {
        print OUTPUT $_, "\n";
}

sub getBranchDeviceReviewer() {
    my $te = HTML::TableExtract->new( attribs => { cellpadding => 3 } );
    $te->parse( $page->asXml );

    my @branch_device_reviewer = ();
    foreach my $ts ( $te->tables ) {
        foreach my $row ( $ts->rows ) {
            my @rs = @$row;

            $rs[0] =~ s/\s+/,/g;
            
            my @ele = split( ',', $rs[0] );
            if ( $ele[2] ne "" ) {

                $rs[1] =~ s/\s+/ \& /g;
                $rs[1] =~ s/^ \& //;
                $rs[1] =~ s/ \& $//;
                push @branch_device_reviewer, "$ele[2],$ele[1],$rs[1]";
            }
        }
    }

    return @branch_device_reviewer;
}

close OUTPUT;
