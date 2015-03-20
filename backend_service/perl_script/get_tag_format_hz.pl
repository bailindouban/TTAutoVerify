#!/usr/bin/perl  For vendor/amax-prebuilt
use strict;
use feature qw(switch);
use WWW::HtmlUnit;
use HTML::TableExtract;
print "\n*********** Get Format Tag ************\n\n";

my $path = "/home/junzheng_zhang/Desktop/kim/tags/hz";
my $url  = "http://10.78.24.12/branchinfo/branchinfo_rec.html";

my $username = "junzheng_zhang";
my $password = "!a159357";

my $webClient           = WWW::HtmlUnit->new;
my $credentialsProvider = $webClient->getCredentialsProvider;
$credentialsProvider->addCredentials( $username, $password );
my $page = $webClient->getPage($url);

# Get Branch Info
my %branch_device = &getBranchDevice();
my $path_branch   = $path . "/branch.csv";
if(-e $path_branch) {
    unlink $path_branch;
}
foreach my $branch ( keys %branch_device ) {
    printFileAdd( $branch . ',' . $branch_device{$branch}."\n", $path_branch );
}
print "Branch Number: ", scalar( keys %branch_device ), "\n";

# Get Project Info
my @projects     = &getProject();
my $path_project = $path . "/project.txt";
printFile( join( "\n", @projects ), $path_project );
print "Project Number: ", scalar(@projects), "\n";

#my @projects = ( $projects[0]);
my @titles        = ( "Branch", "Tags", "APK Version", "TT Bugs", "Change Link", "Message", "Commit Id" );
my $vendor_or_out = "vendor";
my $output_num    = 10;
foreach my $project (@projects) {

    # Welcome and require user input parameters.
    my @devices  = ();
    my @branches = ();
    for my $branch ( keys %branch_device ) {
        push @branches, $branch;
        push @devices,  $branch_device{$branch};
    }

    # Open output tag file
    my $base_tag = "$path/tags";
    if ( !( -e "$base_tag" ) ) {
        system("mkdir $base_tag");
    }

    if ( !( -e "$base_tag/$project" ) ) {
        system("mkdir $base_tag/$project");
    }

    my $output     = "$base_tag/$project/tags_format_" . $project . "_" . $vendor_or_out . "_format_multi.csv";
    my $output_old = "$base_tag/$project/tags_format_" . $project . "_" . $vendor_or_out . "_format_old.csv";
    my $output_com = "$base_tag/$project/tags_format_" . $project . "_" . $vendor_or_out . "_format_compare.csv";

    # Copy to old
    if ( !( -e $output_old ) ) {
        open( FH, ">$output_old" ) or die $!;
        close FH;
    }
    if ( !( -e $output_com ) ) {
        open( FH, ">$output_com" ) or die $!;
        close FH;
    }
    if ( !( -e $output ) ) {
        open( FH, ">$output" ) or die $!;
        close FH;
    }

    system("rm $output_old $output_com");
    system("cp $output $output_old");
    system("rm $output");
    open( OUTPUT_OLD, "$output_old" ) or die $!;
    my @olds = <OUTPUT_OLD>;
    shift @olds;
    shift @olds;
    my $olds_count = scalar(@olds);
    close OUTPUT_OLD;

    # print title
    &printTitle( $output,     $project );
    &printTitle( $output_com, $project );

    open(LOG, ">>/home/junzheng_zhang/Documents/DevelopeTools/TTAutoVerify/backend_service/perl_script/LOG.txt") or die $!;     
    my ($sec, $min, $hour, $day, $mon, $year) = localtime();
    $mon+=1;
    $year+=1900;
    print LOG "$vendor_or_out/$project\t\tTime: $hour:$min:$sec, $day/$mon/$year\n";    
    # Do work!
    my $branch_count = scalar(@branches);
    for ( my $i = 0 ; $i < $branch_count ; $i++ ) {
        &doWork( $i, $olds[$i], $output, $project, @olds);
        # &doWork( $i, $olds[$i], $output_com, $project, @olds);
    }

    close LOG;

    sub getCompareEle() {
        ( my $bra, my $ele_index, my @olds ) = @_;
        for ( my $i = 0 ; $i < $olds_count ; $i++ ) {
            chomp $olds[$i];
            my @ele = split( ',', $olds[$i] );
            my $b = $ele[0];
            $b =~ s/.*?\[//;
            $b =~ s/\]//g;
            if ( $bra eq $b ) {
                given ($ele_index) {
                    when (0) { return $b; }
                    when (1) { return $ele[1]; }
                    when (2) { return $ele[2]; }
                    default  { return "error param"; }
                }
            }
        }
        return "new branch";
    }

    sub printTitle() {
        ( my $output, my $project ) = @_;

        # print title
        open( OUTPUT, ">>$output" ) or die $!;
        print OUTPUT "$project - $vendor_or_out\n";
        print OUTPUT ( join( ",", @titles ), "\n" );

        close OUTPUT;
    }

    sub printCompareOrNot() {
        ( my $hl, my $old, my $new, my $isCompare ) = @_;
        if ( $old ne $new && $isCompare ) {
            print $hl "$old -> ";
        }
        print $hl "$new,";
    }

    sub doWork() {
        ( my $p1, my $old, my $output, my $project, my @olds) = @_;
        my $isCompare = $output =~ /compare/;

        open( my $hl, ">>$output" ) or die $!;


        # checkout, reset and pull
        print "\n\n************************** Now at branch $p1. $branches[$p1], total branch count: $branch_count\n\n";
        print "\n\n************************** Checkout $branches[$p1] ***************************\n\n";
        system("git ch $branches[$p1]");

        if($project eq "AsusEmail") {
            print LOG "RESET ... PULL\n";
            print "\n\n************************** Reset ****************************\n\n";
            for ( my $k = 0 ; $k < 3 ; $k++ ) {
                if ( $vendor_or_out == "out" ) {
                    system("git reset --hard HEAD~1");
                }
                else {
                    system("git reset --hard HEAD~3");
                }
                system("git clean -fd");        # clean red files
            }
            print "\n\n*************************** Pull ****************************\n\n";
            system("git p");
        }

        chomp $old;
        my @ele = split( ",", $old );

        # 1. print tags to file tags.txt
        print "\n******************** device: $devices[$p1], branch: $p1. $branches[$p1] ******************\n\n";
        my $bra     = $branches[$p1];
        my $bra_com = &getCompareEle( $bra, 0, @olds );
        my $bra_dev = "$devices[$p1] \[$bra\]";


        # print extract result to tags.txt
        my $temp_commitId  = `git log --grep=$project -$output_num --pretty=format:\"%h\" $branches[$p1]`;
        my @temp_commitIds = split( "\n", $temp_commitId );
        if ( $temp_commitIds[0] eq "" ) {
            print $hl "\n";
        }
        else {
            for ( my $i = 0 ; $i < scalar(@temp_commitIds) ; $i++ ) {
                chomp $temp_commitIds[$i];                 

                my $temp_message   = `git show $temp_commitIds[$i] --grep=$project --pretty=oneline $branches[$p1] | git name-rev --tags --stdin`;
                $temp_message =~ s/\n//g;
                $temp_message =~ s/diff --.*//;

                # branch
                if ( $bra_com ne $bra ) {
                    print $hl "$bra_com -> ";
                }
                print $hl "$bra_dev,";

                # tag
                my $tag_com = &getCompareEle( $bra, 1, @olds );
                if ( $temp_message =~ /\((tags\/.+?)\)/ ) {
                    my $tag = $1;
                    $tag =~ s/tags\///;
                    $tag =~ s/[\^\~].*//;
                    &printCompareOrNot( $hl, $tag_com, $tag, $isCompare );
                }
                else {
                    &printCompareOrNot( $hl, $tag_com, '', $isCompare );
                }

                # apk version
                my $apk_com = &getCompareEle( $bra, 2, @olds );
                my $temp_apk = "";
                if ( $vendor_or_out eq "out" ) {
                    $temp_apk = `aapt dump badging /home/junzheng_zhang/Desktop/codebase/4.4-clock/packages/apps/*$project/out/*.apk | grep versionName`;
                }
                else {
                    $temp_apk = `aapt dump badging /home/junzheng_zhang/Desktop/codebase/amax-prebuilt/clock/*$project/*.apk | grep versionName`;
                }

                if ( $temp_apk =~ /versionName='(.*)'/ ) {
                    my $apk = 'V' . $1;
                    chomp $apk;
                    &printCompareOrNot( $hl, $apk_com, $apk, $isCompare );
                }
                else {
                    &printCompareOrNot( $hl, $apk_com, '', $isCompare );
                }

                # TT bugs
                my $bug_mes = `git show $temp_commitIds[$i] --grep=$project $branches[$p1] | git name-rev --tags --stdin`;
                $bug_mes =~ s/\n//g;                
                $bug_mes =~ s/Change-Id: .*//;
                $bug_mes =~ s/.*?\[//;
                my @bugs = $bug_mes =~ /[^.](\d{6})/g;
                my %count;
                my @bugs_unique = grep(!$count{$_}++, @bugs);
                print $hl join(" & ", @bugs_unique),",";

                # Change Link
                my $temp_changelink = `git show $temp_commitIds[$i] | grep Reviewed-on`;
                my @temp_changelinks = split( "\n", $temp_changelink );
                if ( $temp_changelinks[0] ne "" ) {
                    chomp $temp_changelinks[0];
                    $temp_changelinks[0] =~ s/    Reviewed-on: //;
                    print $hl "$temp_changelinks[0],";
                }
                else {
                    print $hl ",";
                }

                # Message
                if ( $temp_message =~ /(\[.*)/ ) {
                    my $mes = $1;
                    $mes =~ s/,/;/g;
                    print $hl "$mes,";
                }
                else {
                    print $hl ",";
                }

                # Commit Id
                print $hl $temp_commitIds[$i] . ",\n";

            }
        }
        close $hl;
    }

    print "\n\n**************** Finished ! \ntags.txt path is $output\n\n";
}

sub getProject() {
    my $path_project = $path . "project.txt";

    my $te = HTML::TableExtract->new( attribs => { cellpadding => 3 } );
    $te->parse( $page->asXml );

    my @projects = ();
    foreach my $ts ( $te->tables ) {
        my @rs_pro = $ts->row(0);
        foreach (@rs_pro) {
            $_ =~ s/\s//g;
            push @projects, $_;
        }
    }
    shift @projects;
    shift @projects;
    shift @projects;
    pop @projects;

    return @projects;
}

sub getBranchDevice() {
    undef $/;
    open(HTML, 'parse_html/ASUS Tool Site.html') or die $!;
    my $page_local = <HTML>;
    close HTML;
    $/ = "\n";

    my $te = HTML::TableExtract->new();
    $te->parse( $page_local);

    my %branch_device = ();
    foreach my $ts ( $te->tables ) {
        foreach my $row ( $ts->rows ) {
            my @rs = @$row;
            if($rs[0] eq "ON") {
                $rs[1] =~ s/\n//g;
                $rs[1] =~ s/\t*//g;
                $branch_device{ $rs[2] } = $rs[1];
            };
        }
    }
    return %branch_device;
}

sub printFile() {
    ( my $con, my $file ) = @_;

    # Delete File if exist
    if ( -e $file ) {
        unlink $file;
    }

    open( FH, ">$file" ) or die $!;
    print FH $con;
    close FH;
}

sub printFileAdd () {
    ( my $con, my $file ) = @_;
    open( FH, ">>$file" ) or die $!;
    print FH $con;
    close FH;
}

