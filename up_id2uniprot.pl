my %id2uniprot;
for(`cat human_gene_id2uniprot`){
    chomp;
    my @data = split(/\t/, $_);
    if($data[1] =~ /Error/){
	$id2uniprot{$data[0]} = "-";	
    }else{
	$id2uniprot{$data[0]} = $data[1];
    }
}
for(`cat upstream.tsv`){
    chomp;
    if(/^Gene/){
	print "Uniprot\t".$_."\n";
    }
    my @data = split(/\t/, $_);
    my $line = $_;
    if($line =~ /gene\=(\S+) /){
	my $gene = $1;
	$gene =~ s/\[//g;
	$gene =~ s/\]//g;
	print $id2uniprot{$gene}."\t";
    }
    print $line."\n";
}

