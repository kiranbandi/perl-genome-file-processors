#!/usr/bin/perl

# -g, --gff-file : filename for the gff3 containing features
# -w, --window: the size of windows to calculate feature density
use strict;
use warnings;
use Getopt::Long;
use POSIX;

main();

sub main
{
	my $options = {};
	my $command_line = join(" ", ('gff_to_feature_count_bedgraph.pl', @ARGV));

	GetOptions($options, 'gff_file|g=s','window|w=i');

	my $windowSize = $options->{'window'};
	my %windows = (); #hash of windows
	my $fh = $options->{'gff_file'};
	open( GFF, "< $fh" ) or die "Cannot open GFF file: $fh\n";

	while( <GFF> ){
	
		chomp($_);
		next if( $_ =~ /^#.*$/ );
	
		#extract fields from each line of GFF3
		my ($chr, $source, $start, $end) = split("\t", $_);
	
		# Determine if feature rests on a window boundary:
		if( bin($start, $windowSize) != bin($start, $windowSize) ){
			#Feature is over a window boundary
			#Calculate number of bases in each window and increment totals

			#window boundary = bin# * $windowSize
			my $boundary_position = bin($start, $windowSize) * $windowSize;

			if( !defined($windows{$chr}{bin($start, $windowSize)}) ){ 
				$windows{$chr}{bin($start, $windowSize)} = 0;
			} elsif( !defined($windows{$chr}{bin($end, $windowSize)}) ){
				$windows{$chr}{bin($end, $windowSize)} = 0;
			}

			#increment feature count for both windows
			$windows{$chr}{bin($start, $windowSize)} += 1;
			$windows{$chr}{bin($end, $windowSize)} += 1;
		} else {
			#Feature is within a single bin
			#Increment total bases covered for each window

			if( !defined($windows{$chr}{bin($start, $windowSize)}) ){ 
				$windows{$chr}{bin($start, $windowSize)} = 0;
			}
			$windows{$chr}{bin($start, $windowSize)} += 1;
		}

	}

	#Print the contents of $windows:
	foreach my $chr ( sort keys %windows ){
		foreach my $bin ( sort { $a <=> $b } keys %{$windows{$chr}} ){
			print STDOUT join("\t", $chr, ($bin * $windowSize - $windowSize + 1), $bin * $windowSize, $windows{$chr}{$bin}) . "\n"; 
		}
	}
}

#given an integer and windowSize, calculate the binNumber
sub bin
{
	my ($pos, $windowSize) = @_;
	return floor($pos/$windowSize) + 1;
}
