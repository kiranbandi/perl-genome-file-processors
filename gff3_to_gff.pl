# !/usr/bin/perl

# Sample Output File Format
# os3	Os03t0600800	23245405	23247086
# os1	Os01t0765200	33971011	33974537
# os11	Os11t0158500	2817340	2819158

# We only read the lines that have the third column as "mRNA" , since we used the CDS Fasta file for making the BLAST search and it only has the mRNA indices


open INFILE,"human.GFF3";


$dnaSequence="";

open OUTFILE, '>output.gff';

while (defined($line = <INFILE>)){
    chomp($line);
     @lineArray = split("\t",$line);

    if($lineArray[2] eq 'mRNA'){
        # replace the species Name
        $name = $lineArray[0];

        # Split the last array element to get the ID of the gene
        @IDarray = split(";",$lineArray[8]);
        $ID = substr($IDarray[0],3);

        $outLine = join("\t",$name,$ID,$lineArray[3],$lineArray[4]);
        print OUTFILE "$outLine \n"; 
    }

}
close INFILE;
close OUTFILE;

