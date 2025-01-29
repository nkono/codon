import sys
import requests

def gene_id_to_uniprot_id(gene_id):
    url = f"https://rest.uniprot.org/uniprotkb/search?query={gene_id}&fields=accession"
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    if data and 'results' in data and data['results']:
        uniprot_id = data['results'][0]['primaryAccession']
        return uniprot_id
    else:
        raise ValueError(f"Uniprot ID not found for gene ID: {gene_id}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 id2uniprot.py <gene_id>")
        sys.exit(1)

    gene_id = sys.argv[1]
    try:
        uniprot_id = gene_id_to_uniprot_id(gene_id)
        print(uniprot_id)
    except Exception as e:
        print(f"Error: {e}")

