#!perl -w

use warnings;
use strict;

open (SITE1,"$ARGV[0]") or die "cna't open file $ARGV[0]";
open (SITE2,"$ARGV[1]") or die "cna't open file $ARGV[1]";
open (OUT,">$ARGV[2]") or die "cna't create file $ARGV[2]";

my (@site1, @mass1, @El_comp_1, @Class_1, @MolForm_1, @C1, @N1, @H1, @O1, @P1, @S1) = ();
my $title = <SITE1>;
while(my $line = <SITE1>){
	$line =~ s/\s+$//ig;
	my @fields = split /\t/, $line;
	push @site1, $fields[0]; 
	push @mass1, $fields[1];
	push @C1, $fields[2];
	push @H1, $fields[3];
	push @O1, $fields[4];
	push @N1, $fields[5];
	push @S1, $fields[6];
	push @P1, $fields[7];
	push @El_comp_1, $fields[8];
	push @Class_1, $fields[9];
	push @MolForm_1, $fields[10];
}
close SITE1;

$title = <SITE2>;
while(my $line = <SITE2>){
	$line =~ s/\s+$//ig;
	my @fields = split /\t/, $line;
	for(my $i=0;$i<scalar(@site1);$i++){
		if($H1[$i] == $fields[3]){
			next;
		}
		if($C1[$i] == $fields[2] && $O1[$i] == $fields[4] && $H1[$i] != $fields[3] && $P1[$i] == $fields[7] && $S1[$i] == $fields[6] && $N1[$i] == $fields[5] && abs($H1[$i]-$fields[3])%2 == 0){
			my $h_diff = ($H1[$i]-$fields[3])/2;
			print OUT "$site1[$i]	$fields[0]	$mass1[$i]	$fields[1]	$El_comp_1[$i]	$fields[8]	$Class_1[$i]	$fields[9]	$MolForm_1[$i]	$fields[10]	$h_diff\n";
		}
	}
}
close SITE2;
close OUT;

