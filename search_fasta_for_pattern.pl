# Exercise 3 – Venkat K Bandi 

# !/usr/bin/perl
print "Please enter the name of the input FASTA file : ";
chomp($fileName=<>);
open INFILE,$fileName;
$dnaSequence="";

# We assume the fasta file has only one sequence and is not a multi fasta 
# and store the sequence as one string by concatinating lines together
while (defined($line = <INFILE>)){
    chomp($line);
    $firstCharacterOfLine = substr $line, 0, 1;
    if(!($firstCharacterOfLine eq '>')){
        $dnaSequence.= $line;    
    }
}
close INFILE;

# Test Sequence for pattern --> There are only 3 possible scenarios 
# case 1- Both patterns are present
# case 2- Only pattern 1 is present 
# case 3- Neither patterns are present
# (Since pattern 2 isnt possible without the first)

if($dnaSequence =~ /((TTGACA[ATCG]{15,20}TATAAT)([ATCG]{7,14}ATG|))/){
    # case 1
    if($3){
        $pattern = substr $1,0,-3;
        print "1) ",$2,"\n";
        print "2) ",$pattern,"\n";
    }
    # case 2
    else {
      print "1) ",$1,"\n";  
    }
}
# case 3
else {
    print "Neither patterns were found\n";
}

# Sample FASTA file used for testing 
# >1433 Test
# ACTTTGACAAAAAATTTTTCCCCCGTATAATGCTAGCTAACATGACTGACTAGCTAGCTAACTGACTGACTAGCTAGCTAACTG
