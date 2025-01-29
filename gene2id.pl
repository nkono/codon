for(`cat human_gene_id`){
    chomp;
    my $id = $_;
    my $uniprot = `python3 id2uniprot.py $id`;
    chomp($uniprot);
    print $id."\t".$uniprot."\n";
}

