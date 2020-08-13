# !/usr/bin/perl

# Sample Output File Format
# os3	Os03t0600800	23245405	23247086
# os1	Os01t0765200	33971011	33974537
# os11	Os11t0158500	2817340	2819158

# We only read the lines that have the third column as "mRNA" , since we used the CDS Fasta file for making the BLAST search and it only has the mRNA indices


open INFILE,"chimp_gene_count.txt";

open OUTFILE, '> chimp.txt';

while (defined($line = <INFILE>)){
    chomp($line);
    @lineArray = split("\t",$line);
    $outLine = join("\t",'pt'.$lineArray[0],$lineArray[1],$lineArray[2],$lineArray[3]);
    print OUTFILE "$outLine \n"; 
    }


close INFILE;
close OUTFILE;
