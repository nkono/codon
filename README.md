# codon
A Program to Investigate Codon Usage Frequency in the Human Genome

## Description
This repository provides Perl scripts to analyze and compute codon usage frequency in the human genome. It covers:
- Gene body codon usage
- 160 bp upstream codon usage in all three frames
- Mapping of gene IDs to UniProt IDs

## System Requirements
- **Perl** (tested with Perl 5.xx or later)

## Required Files
1. **GCF_000001405.40_GRCh38.p14_cds_from_genomic.fna**  
   - The coding DNA sequences (CDS) from the human genome.
2. **GCF_000001405.40_GRCh38.p14_protein.faa**  
   - The corresponding protein sequences.

Make sure these files are placed in the same directory as the Perl scripts (or modify the scripts accordingly if placed elsewhere).

## Usage

### 1. Preparation
Run the following command to create a file mapping human gene IDs to UniProt IDs:
```bash
perl gene2id.pl > human_gene_id2uniprot
```
This will generate human_gene_id2uniprot, which will be used for subsequent analyses.

### 2. Gene Body Codon Usage
Generate codon usage data for gene bodies:
```bash
perl base.pl > GeneBody.tsv
```
Convert gene IDs in GeneBody.tsv to UniProt IDs:
```bash
perl body_id2uniprot.pl > GeneBody_uniprot.tsv
```
### 3. Upstream (160 bp) Codon Usage
Generate codon usage data for the 160 bp region upstream of each gene (in three frames):
```bash
perl upstream.pl > upstream.tsv
```
Convert gene IDs in upstream.tsv to UniProt IDs:
```bash
perl up_id2uniprot.pl > upstream_uniprot.tsv
```

## Contributing
Pull requests and issues are welcome. Feel free to propose new features or report any bugs you encounter.

## License
This project is available under the MIT License. See the LICENSE file for details.

## Publication
Yuki Iimori, Teppei Morita, Takeshi Masuda, Shojiro Kitajima, Nobuaki Kono, Shun Kageyama, Josephine Galipon, Atsuo T. Sasaki, Akio Kanai, SLFN11-mediated tRNA regulation induces cell death by disrupting proteostasis in response to DNA-damaging agents, bioRxiv, 2025.01.08.632070; doi: https://doi.org/10.1101/2025.01.08.632070
