# !/usr/bin/perl
open INFILE,"human_cds_fasta_all.fa";
open OUTFILE, '> modified_human_cds_fasta.fa';

while (defined($line = <INFILE>)){
    # Read the line
    chomp($line);
    if($line =~ />(\w{2,}).[0-9]/){
      print OUTFILE ">$1\n"
    }
    else {
        print OUTFILE "$line\n"
    }
}
close INFILE;
close OUTFILE;

