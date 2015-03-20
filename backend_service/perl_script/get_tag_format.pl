#!/usr/bin/perl  For vendor/amax-prebuilt
use strict;
use feature qw(switch);

print "\n*********** Get Format Tag ************\n\n";

my $project = $ARGV[0];
if ( $project eq "" ) {
    print "\nPlease use the script as: 'perl get_tag.pl project-name(ex. AsusDeskClock)'.\n\n";
}
else {
    # determine the output folder path.
    opendir( DIR, "./" ) or die $!;
    my @dir = readdir(DIR);

    my $vendor_or_out = "vendor";
    if ( grep /^out$/, @dir ) {
        $vendor_or_out = "out";
    }
    close DIR;

    # Read branch file
    my $base_origin = "/home/junzheng_zhang/Desktop/kim";
    my $base_folder = "$base_origin/$vendor_or_out";

    if ( $project eq "ASUSAccount" or $project =~ /SoundRecorder/ ) {
        open( BRANCH, "$base_folder/branches_account.csv" ) or die $!;
    }
    else {
        open( BRANCH, "$base_folder/branches.csv" ) or die $!;
    }

    my @device_remote_branch = <BRANCH>;
    my $branch_count         = scalar(@device_remote_branch);

    # Welcome and require user input parameters.
    my @devices  = ();
    my @remotes  = ();
    my @branches = ();
    for ( my $i = 0 ; $i < $branch_count ; $i++ ) {
        chomp $device_remote_branch[$i];
        my @temp = split( ",", $device_remote_branch[$i] );
        $devices[$i]  = $temp[0];
        $remotes[$i]  = $temp[1];
        $branches[$i] = $temp[2];
        print "$i\t$branches[$i]\n";
    }
    print "$branch_count\tAll\n";
    print "Please select the branch number(ex: 0,1...):";

    #my $input = <STDIN>;
    my $input = $branch_count;
    chomp $input;

    #check user input
    my @select_num   = split( ",", $input );
    my $select_count = scalar(@select_num);
    my $flag         = 0;
    foreach (@select_num) {
        if (/\d+/) {
            if ( $select_count > 1 && $_ == $branch_count ) {
                print "\n************** It seems you have already select some branches, so you should not select all\n\n";
                $flag = 1;
                last;
            }
            elsif ( $_ >= 0 && $_ <= $branch_count ) {
                next;
            }
            else {
                print "\n************** Please input one or more proper numbers which is between 0 and $branch_count\n\n";
                $flag = 1;
                last;
            }
        }
        else {
            print "\n************** Please input digital numbers\n\n";
            $flag = 1;
            last;
        }
    }

    # Open output tag file
    my $base_tag = "$base_origin/tags";
    if ( !( -e "$base_tag" ) ) {
        system("mkdir $base_tag");
    }

    if ( !( -e "$base_tag/$project" ) ) {
        system("mkdir $base_tag/$project");
    }

    my $output     = "$base_tag/$project/tags_format_" . $project . "_" . $vendor_or_out . "_format.csv";
    my $output_old = "$base_tag/$project/tags_format_" . $project . "_" . $vendor_or_out . "_format_old.csv";
    my $output_com = "$base_tag/$project/tags_format_" . $project . "_" . $vendor_or_out . "_format_compare.csv";

    my $output_multi   = "$base_tag/$project/tags_format_" . $project . "_" . $vendor_or_out . "_format_multi.csv";

    # Copy to old
    if(-e $output_old) {
        system("rm $output_old");
    }
    if(-e $output_com) {
        system("rm $output_com");
    }
    if(-e $output) {
        system("cp $output $output_old");
        system("rm $output");
    }
    if(-e $output_multi) {
        system("rm $output_multi");
    }   

    open( OUTPUT_OLD, ">$output_old" ) or die $!;
    my @olds       = <OUTPUT_OLD>;
    if(scalar(@olds) > 1) {      
        shift @olds;
        shift @olds;
    }
    my $olds_count = scalar(@olds);
    close OUTPUT_OLD;

    my @titles = ( "Branch", "Tags", "APK Version", "TT Bugs", "Change Link", "Message", "Commit Id" );

    # print title
    &printTitle($output);
    &printTitle($output_com);
    &printTitle($output_multi);

    # Do work!
    if ( $flag == 0 ) {

        # User select All
        if ( $input == $branch_count ) {
            for ( my $i = 0 ; $i < $branch_count ; $i++ ) {
                &doWork( $i, $branch_count, $olds[$i] );
            }
        }

        # User select some branches
        else {
            foreach (@select_num) {
                &doWork( $_, $select_count, $olds[$_] );
            }
        }
    }

    close BRANCH;
    close MESSAGE;

    sub getCompareEle() {
        ( my $bra, my $ele_index ) = @_;
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

    sub doWork {
        ( my $p1, my $p2, my $old) = @_;

        printOutput( $p1, $p2, $old, $output, 1 );
        printOutput( $p1, $p2, $old, $output_com, 1 );

        printOutput( $p1, $p2, $old, $output_multi, 10 );
    }

    print "\n\n**************** Finished ! \ntags.txt path is $output\n\n";

    sub printTitle() {
        ( my $output ) = @_;

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

    sub printOutput() {
        ( my $p1, my $p2, my $old, my $output , my $output_num) = @_;
        my $isCompare = $output =~ /compare/;

        open( my $hl, ">>$output" ) or die $!;
      
        # checkout, reset and pull
        print "\n\n************************** Now at branch $p1. $branches[$p1], total branch count: $p2\n\n";
        print "\n\n************************** Checkout $branches[$p1] ***************************\n\n";
        system("git ch $branches[$p1]");
        
        if($output =~ /format\.csv/) {
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
        print "\n******************** device: $devices[$p1],remote: $remotes[$p1],branch: $p1. $branches[$p1] ******************\n\n";
        my $bra     = $branches[$p1];
        my $bra_com = &getCompareEle( $bra, 0 );
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
                if ( $bra_com ne $bra) {
                    print $hl "$bra_com -> ";
                }
                print $hl "$bra_dev,";

                # tag
                my $tag_com = &getCompareEle( $bra, 1 );
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
                my $apk_com = &getCompareEle( $bra, 2 );
                my $temp_apk = "";
                my $isSR = "";
                if($project eq "SoundRecorder") {
                    $isSR = 'AMAX/';
                }
                if ( $vendor_or_out eq "out" ) {
                    $temp_apk = `aapt dump badging /home/junzheng_zhang/Desktop/codebase/4.4-clock/packages/apps/*$project/out/$isSR*.apk | grep versionName`;
                }
                else {
                    $temp_apk = `aapt dump badging /home/junzheng_zhang/Desktop/codebase/amax-prebuilt/clock/*$project/$isSR*.apk | grep versionName`;
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
                print $hl join(" & ", @bugs_unique), ",";

                # Change Link
                my $temp_changelink = `git show $temp_commitIds[$i] | grep Reviewed-on`;
                my @temp_changelinks = split("\n", $temp_changelink);
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

    my ($sec, $min, $hour, $day, $mon, $year) = localtime();
    $mon+=1;
    $year+=1900;
    open(LOG, ">>/home/junzheng_zhang/Documents/DevelopeTools/TTAutoVerify/backend_service/perl_script/LOG.txt") or die $!;
    print LOG "$vendor_or_out/$project\t\tTime: $hour:$min:$sec, $day/$mon/$year\n";    
    close LOG;
}
