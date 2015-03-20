#!/user/bin/perl -w
use strict;

my @projects = ("DeskClock", "ASUSAccount", "SoundRecorder", "FlashLight");
my $old_path = "/home/junzheng_zhang/Desktop/kim/tags/";
my $new_path = $old_path."hz/tags/";

my ($sec, $min, $hour, $day, $mon, $year) = localtime();
$mon+=1;
$year+=1900; 

for(my $i = 0; $i < scalar(@projects); $i++) {
    if(-e $new_path) {
        system("rm -rf $new_path$projects[$i]");
    }
    system("mkdir $new_path$projects[$i]");
    
    &combineFile($projects[$i], "");
    &combineFile($projects[$i], "_compare");
    &combineFile($projects[$i], "_multi");
}

sub combineFile {
    (my $project, my $isCompare) = @_;
    
    print $project."\n";
    my $vendor_file = $old_path.$project."/tags_format_".$project."_vendor_format".$isCompare.".csv";
    my $out_file = $old_path.$project."/tags_format_".$project."_out_format".$isCompare.".csv";
    my $combine_file = $new_path.$project."/tags_format_".$project."_vendor_format".$isCompare.".csv";
    open(VENDOR, $vendor_file) or die $!;
    open(OUT, $out_file) or die $!;
    open(COMBINE, ">".$combine_file) or die $!;
    
    print COMBINE "Time: $hour:$min:$sec, $day/$mon/$year\n";
    while(<VENDOR>) {
        print COMBINE $_;
    }
    print COMBINE "\n";
    while(<OUT>) {
        print COMBINE $_;
    }

    close VENDOR;
    close OUT;
    close COMBINE;
}
