use strict;

my $coding = "GCF_000001405.40_GRCh38.p14_cds_from_genomic.fna";
my $protein = "GCF_000001405.40_GRCh38.p14_protein.faa";
#my $genome = "";

my %data;
my ($key);
for(`cat $coding`){
    chomp;
    if(/>(.+)/){
	$key = $1;
    }else{
	$data{$key} .= $_;
    }
}

my %codon;
for my $key (keys %data){
#    print $key."\n";
    my $seq = $data{$key};
#    print $seq."\n";
    for(my $i = 0; $i < length($seq) - 2; $i += 3){
#	print substr($seq, $i, 3)."\n";
	$codon{$key}{substr($seq, $i, 3)} ++;
    }
}

my %all_codon;
my @nuc = qw(A T G C);
for my $nuc1 (@nuc){
    for my $nuc2 (@nuc){
	for my $nuc3 (@nuc){
	    $all_codon{$nuc1.$nuc2.$nuc3} ++;
	}
    }
}

print "Gene";
for my $codon (sort keys %all_codon){
    print "\t".$codon;
}
print "\n";

for my $key (sort keys %codon){
    print $key;
    for my $codon (sort keys %all_codon){
	if($codon{$key}{$codon} > 0){
	    print "\t".$codon{$key}{$codon};
	}else{
	    print "\t0";
	}
    }
    print "\n";
}



__END__
lcl|NC_000012.12_cds_NP_000005.3_79056



