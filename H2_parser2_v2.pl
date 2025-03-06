#!perl -w

# load the required modules
use warnings;
use strict;
use Getopt::Long;

# usage
sub usage {
	print <<USAGE;

usage:
	perl $0 [options]
description:
	
	This program will search the mass output for the dehydrogenation during the anaerobic digestion.
	
options:
	-help: print help info
	-site1     *   <str>   : Mass output before anaerobic digestion. (required)
	-site2     *   <str>   : Mass output after anaerobic digestion. (required)
	-output   *   <str>   : Output directory. (default: interim) (required)
	-h   :   print help info
e.g.:
	perl $0 -site1 site1-v2.txt  -site2 site2-v2.txt  -output CO2_parser.txt
USAGE
}

# declares four lexical variables
my ($site1_file, $site2_file, $output_file, $help);

# parse command line options
GetOptions(
    "site1=s"  => \$site1_file,   # -site1 parameter
    "site2=s"  => \$site2_file,   # -site2 parameter
    "output=s" => \$output_file,  # -output parameter
    "help"     => \$help,         # --help
    "h"        => \$help          # -h (short form)
) or die "Error: Invalid command line arguments\n";

# Show help if requested or missing required parameters
if ($help || !$site1_file || !$site2_file) {
    &usage();
    exit 0;
}

# Open input files
open(my $SITE1, '<', $site1_file) or die "Can't open site1 file '$site1_file': $!";
open(my $SITE2, '<', $site2_file) or die "Can't open site2 file '$site2_file': $!";

# Create output file
our ($OUT);
open($OUT,   '>', $output_file) or die "Can't create file $output_file: $!";

# initializing the array variables
my (@sample1, @site1, @mass1, @El_comp_1, @Class_1, @MolForm_1, @C1, @N1, @H1, @O1, @P1, @S1) = ();

# read the first line to test whether the file is successfully opened
my $title = <$SITE1>;

# read the file line by line
while(my $line = <$SITE1>){
	$line =~ s/\s+$//ig; # trim trailing whitespace​
	my @fields = split /\t/, $line; # split the line by tab
	push @sample1, $fields[0];
	push @site1, $fields[1]; 
	push @mass1, $fields[2];
	push @C1, $fields[3];
	push @H1, $fields[4];
	push @O1, $fields[5];
	push @N1, $fields[6];
	push @S1, $fields[7];
	push @P1, $fields[8];
	push @El_comp_1, $fields[10];
	push @Class_1, $fields[11];
	push @MolForm_1, $fields[9];
}
# close the first input file
close $SITE1;

# read the first line to test whether the file is successfully opened
$title = <$SITE2>;

#read the file line by line
while(my $line = <$SITE2>){
	$line =~ s/\s+$//ig; # trim trailing whitespace​
	my @fields = split /\t/, $line; # split the line by tab
	
	# search for the dehydrogenation line by line
	for(my $i=0;$i<scalar(@site1);$i++){
		# same sample with different number of hydrogen atoms
		if($site1[$i] eq $fields[1] && $H1[$i] != $fields[4]){
			# dehydrogenation: the reduction of hydrogen atoms is even number
			if($C1[$i] == $fields[3] && $O1[$i] == $fields[5] && $P1[$i] == $fields[8] && $S1[$i] == $fields[7] && $N1[$i] == $fields[6] && ($H1[$i]-$fields[4])%2 == 0){
				my $h_diff = ($H1[$i]-$fields[4])/2; # number of reduced hydrogen molecules
				
				# write to the output file
				print $OUT "$sample1[$i]	$fields[0]	$mass1[$i]	$fields[2]	$El_comp_1[$i]	$fields[10]	$Class_1[$i]	$fields[11]	$MolForm_1[$i]	$fields[9]	$h_diff\n";
			}
		}
	}
}

# close the second input file
close $SITE2;

# close the output file
close $OUT;


