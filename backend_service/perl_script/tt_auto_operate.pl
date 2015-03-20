#!/usr/bin/perl
use strict;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;

print "Update...\n";
my $url_update = 'http://10.66.2.80:8081/TT_Close_Bug/my_uv.action?operate=1';
my $res_update = $ua->get($url_update);

print "Verify...\n";
my $url_verify = 'http://10.66.2.80:8081/TT_Close_Bug/my_uv.action?operate=3';
my $res_verify = $ua->get($url_verify);

print "Finished!\n";


