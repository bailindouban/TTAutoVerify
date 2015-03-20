#!/usr/bin/perl
use strict;
use WWW::Mechanize;
use WWW::HtmlUnit;
use HTML::TableExtract qw(tree);

# base path
my $path     = "/home/junzheng_zhang/Desktop/kim/tags/hz/tags";
my $url_base = "http://192.168.88.187/tmtrack/";

my $username = "junzheng_zhang";
my $password = "123456";
my $mech = WWW::Mechanize->new( autocheck => 1 );
$mech->credentials( $username, $password );

my $webClient           = WWW::HtmlUnit->new;
my $credentialsProvider = $webClient->getCredentialsProvider;
$credentialsProvider->addCredentials( $username, $password );

# Get all bug list
my $url_tt = $url_base . "tmtrack.dll?ReportPage&Template=reports%2Flist&TableId=1001&Target=Query&QueryName=-6&SolutionId=2&ShowSubLinks=1";

$mech->get($url_tt);
my $link = $mech->find_link( url_regex => qr/Recno=-1/ );
if ( $link ne "" ) {
    $url_tt = $link->url();
}

my $page_all_tt   = $webClient->getPage( $url_base . $url_tt );

my $tt_id = &getFirstTT($page_all_tt->asXml);

# Get Url in List Page
my $url_list = $url_base."tmtrack.dll?ReportPage&Template=reports%2Flist&incsub=1&keywords=$tt_id&options=0&searchtid=1001&solutionid=2&tableid=1001&target=QuickIdSearch";
$mech->get($url_list);

# Goto Detail Page
my $url_detail = $mech->find_link( url_regex => qr/RecordId=/ )->url();
$mech->get($url_detail);

# Goto Update Page
my $res = $mech->submit_form(
        form_name => 'ViewForm',
        button    => 'TransitionId.1'
);
my $update_string = $res->content();

# Break Assign Lock
if ( $res->content() =~ /Break Lock/ ) {
        my $res_break_lock = $mech->submit_form(
            form_name => 'BreakLockForm',
            button    => 'Break'
        );

        $update_string = $res_break_lock->content();
}

# Ouput html files
my $base_output = '/home/junzheng_zhang/Documents/DevelopeTools/TTAutoVerify/front_pages/web/TT_Close_Bug/WebRoot/selector';

my @rd_manager = $update_string =~ /id="F234".*?>(.*?)<\/select>/g;
my $rd_manager = '<select name="userInfo.rd_manager">'.$rd_manager[0]."\n".'</select>';
$rd_manager =~ s/<option/\n\t<option/g;
$rd_manager =~ s/ class=selectedValue selected="" //g;
printFile($rd_manager, $base_output."/rd_manager.html");

my @developer = $update_string =~ /id="F233".*?>(.*?)<\/select>/g;
my $developer = '<select name="userInfo.developer">'.$developer[0]."\n".'</select>';
$developer =~ s/<option/\n\t<option/g;
$developer =~ s/ class=selectedValue selected="" //g;
printFile($developer, $base_output."/developer.html");

sub getFirstTT() {
    ( my $html_string ) = @_;

    # Extract table
    use HTML::TableExtract qw(tree);
    my $te = HTML::TableExtract->new( attribs => { name => "ReportOutput" } );
    $te->parse($html_string);
    

    my @all_tt = ();
    foreach my $table ( $te->tables ) {
        my $table_tree = $table->tree;
        my $t_line     = $table_tree->as_HTML;
        @all_tt = $t_line =~ /RecordId.*?> (\d+?) </g;  
        last;    
    }
    
    return $all_tt[0];
}

sub printFile() {
    ( my $content, my $file ) = @_;
    open( FH, '>' . $file ) or die $!;
    print FH $content;
    close FH;
}

