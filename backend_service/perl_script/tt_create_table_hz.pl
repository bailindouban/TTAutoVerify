#!/usr/bin/perl
use strict;
use DBI;
#use Encode;
#use utf8;
#binmode(STDIN, ':encoding(utf8)');
#binmode(STDOUT, ':encoding(utf8)');
#binmode(STDERR, ':encoding(utf8)');

my $db = "test_2";
my $dbh = &db_operate($db);

# For bug figure
my $table_parse = "parse_tt";
$dbh->do("CREATE TABLE $table_parse (id INT(6) AUTO_INCREMENT, bug_id INT(6), device VARCHAR(25), PRIMARY KEY(id))");

# For verify bug
my $table_verify = "verify_tt";
$dbh->do("CREATE TABLE $table_verify (id INT(6) AUTO_INCREMENT, bug_id INT(6), tag VARCHAR(80), apk_version VARCHAR(30), change_link VARCHAR(200), device VARCHAR(25), branch VARCHAR(80), PRIMARY KEY(id))");

# For user_info
my $table_user_info = "user_info_all";
$dbh->do("CREATE TABLE $table_user_info (username VARCHAR(25), password VARCHAR(25), project VARCHAR(25), rd_manager VARCHAR(25), developer VARCHAR(25), PRIMARY KEY(username, project))");

# For closed bug
my $table_closed_bug = "closed_bug";
$dbh->do("CREATE TABLE $table_closed_bug (id INT(6) AUTO_INCREMENT, username VARCHAR(25), project VARCHAR(25), tt_bug INT(6), tag VARCHAR(80), apk_version VARCHAR(30), change_link VARCHAR(200), device VARCHAR(25), branch VARCHAR(80), PRIMARY KEY(id), FOREIGN KEY(username, project) references $table_user_info(username, project))");

# For updated bug
my $table_updated_bug = "updated_bug";
$dbh->do("CREATE TABLE $table_updated_bug (id INT(6) AUTO_INCREMENT, username VARCHAR(25), project VARCHAR(25), tt_bug INT(6), tag VARCHAR(80), apk_version VARCHAR(30), change_link VARCHAR(200), device VARCHAR(25), branch VARCHAR(80), PRIMARY KEY(id), FOREIGN KEY(username, project) references $table_user_info(username, project))");

sub db_operate() {
	(my $db) = @_;
	my $db_driver = "DBI:mysql:";
	my $db_host = "localhost";
	my $db_username = "root";
	my $db_password = "bailin";
	
	my $dbh = DBI->connect("$db_driver; host=$db_host", $db_username, $db_password) or die $!;

	# TRUN Table;
	$dbh->do("DROP DATABASE if exists $db");
	$dbh->do("CREATE DATABASE $db");
	$dbh->do("USE $db");
        
    	return $dbh;
}

