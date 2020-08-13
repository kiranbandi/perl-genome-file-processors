# Exercise 2 – Venkat K Bandi 

# !/usr/bin/perl
print "Please enter the name of the input FASTA file : ";
chomp($fileName=<>);
open INFILE,$fileName;
#variable to store count of no of proteins
$proteinCount=-1;
while (defined($line = <INFILE>)){
    chomp($line);
    $firstCharacterOfLine = substr $line, 0, 1;
    if($firstCharacterOfLine eq '>'){
        # store header in header array
        push(@proteinHeaderArray,$line);
        # increment protein sequence count
        $proteinCount++;
    }
    else {
        #store actual protein sequence
        $proteinArray[$proteinCount].=$line;   
    }
}
close INFILE;

for ($j=0;$j<=$proteinCount;$j++) {
  $firstTenCharacters = substr $proteinArray[$j], 0, 10;
  $lengthOfSequence = length $proteinArray[$j];
  print "Protein Header : ",$proteinHeaderArray[$j],"\n";  
  print "First 10 Characters of the Sequence : ",$firstTenCharacters,"\n";
  print "No of Amino Acids : ",$lengthOfSequence,"\n\n";
}