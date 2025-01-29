use strict;

my $genome = "Hsap_PrimaryAssembly.fasta";
my $cds = "GCF_000001405.40_GRCh38.p14_cds_from_genomic.fna";

my %genome;
my $key;
my $chr;
for(`cat $genome`){
    chomp;
    if(/\>(.+)/){
	$key = $1;
    }else{
	my @names = split(/\|/, $key);
	$genome{$names[0]} .= $_;
    }
}

my ($gene, $chr, $loc);
my %codon;
for(`cat $cds`){
    chomp;
    if(/\>(.+)/){
	$gene = $1;
	if($gene =~ /lcl\|(.+)_cds/){
	    $chr = $1;
	}
	if($gene =~ /location=(\S+)\)\] /){
	    $loc = $1;
	    $loc =~ s/\D/,/g;
	    $loc =~ s/,{2,}/,/g;
	    $loc =~ s/^,//g;
	    $loc =~ s/,$//g;
	}
	my @pos = split(/\,/, $loc);
#	print $gene."\n";
#	print $chr."\n";
#	print $pos[0]."\n";
#	print $pos[-1]."\n";
	my $len = 120;
	if($gene =~ /complement/){
#	    print "complement\n";
#	    print complement(substr($genome{$chr}, $pos[-1] - 1 - 50, $len + 60))."\n";
#	    print complement(substr($genome{$chr}, $pos[-1] - 1 + 3, $len))."\n";
#	    print complement(substr($genome{$chr}, $pos[-1] - 1 + 2, $len))."\n";
#	    print complement(substr($genome{$chr}, $pos[-1] - 1 + 1, $len))."\n";
	    for(my $i = 0; $i < $len - 1; $i += 3){
		$codon{$gene}{f1}{substr(complement(substr($genome{$chr}, $pos[-1] - 1 + 3, $len)), $i, 3)} ++;
		$codon{$gene}{f2}{substr(complement(substr($genome{$chr}, $pos[-1] - 1 + 2, $len)), $i, 3)} ++;
		$codon{$gene}{f3}{substr(complement(substr($genome{$chr}, $pos[-1] - 1 + 1, $len)), $i, 3)} ++;
#		print "1\t".substr(complement(substr($genome{$chr}, $pos[-1] - 1 + 3, $len)), $i, 3)."\n";
#		print "2\t".substr(complement(substr($genome{$chr}, $pos[-1] - 1 + 2, $len)), $i, 3)."\n";
#		print "3\t".substr(complement(substr($genome{$chr}, $pos[-1] - 1 + 1, $len)), $i, 3)."\n";
	    }
	    
	}else{
#	    print "direct\n";
#	    print substr($genome{$chr}, $pos[0] - 1 - $len - 10, $len + 100)."\n";
#	    print substr($genome{$chr}, $pos[0] - 1 - $len - 2, $len)."\n";
#	    print substr($genome{$chr}, $pos[0] - 1 - $len - 1, $len)."\n";
#	    print substr($genome{$chr}, $pos[0] - 1 - $len, $len)."\n";
	    for(my $i = 0; $i < $len - 1; $i += 3){
		$codon{$gene}{f1}{substr(substr($genome{$chr}, $pos[0] - 1 - $len - 2, $len), $i, 3)} ++;
		$codon{$gene}{f2}{substr(substr($genome{$chr}, $pos[0] - 1 - $len - 1, $len), $i, 3)} ++;
		$codon{$gene}{f3}{substr(substr($genome{$chr}, $pos[0] - 1 - $len, $len), $i, 3)} ++;
#		print "1\t".substr(substr($genome{$chr}, $pos[0] - 1 - $len - 2, $len), $i, 3)."\n";
#		print "2\t".substr(substr($genome{$chr}, $pos[0] - 1 - $len - 1, $len), $i, 3)."\n";
#		print "3\t".substr(substr($genome{$chr}, $pos[0] - 1 - $len, $len), $i, 3)."\n";
	    }
	}
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
    print "\t".$codon." (f1)";
}
for my $codon (sort keys %all_codon){
    print "\t".$codon." (f2)";
}
for my $codon (sort keys %all_codon){
    print "\t".$codon." (f3)";
}
print "\n";

for my $gene (sort keys %codon){
    print $gene;
    for my $codon (sort keys %all_codon){
        if($codon{$gene}{f1}{$codon} > 0){
            print "\t".$codon{$gene}{f1}{$codon};
        }else{
            print "\t0";
        }
    }
    for my $codon (sort keys %all_codon){
        if($codon{$gene}{f2}{$codon} > 0){
            print "\t".$codon{$gene}{f2}{$codon};
        }else{
            print "\t0";
        }
    }
    for my $codon (sort keys %all_codon){
        if($codon{$gene}{f3}{$codon} > 0){
            print "\t".$codon{$gene}{f3}{$codon};
        }else{
            print "\t0";
        }
    }
    print "\n";
}

sub complement{
    my $tmpseq = shift;
    $tmpseq = reverse($tmpseq);
    $tmpseq =~ tr/[atgc|ATGC]/[tacg|TACG]/;
    return $tmpseq;
}
