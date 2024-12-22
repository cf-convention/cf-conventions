#!/usr/bin/env python3

"""
This script parses the authors.adoc file to extract author metadata, update the 
"creators" section in the zenodo.json file, update CITATION.cff and generate the about-authors.adoc file.

Purpose:
  1. Extracts authors' names, affiliations, and ORCID from authors.adoc.
  2. Updates the "creators" section in the zenodo.json file with formatted author names.
  2. Updates the CITATION.cff file.
  3. Generates the about-authors.adoc file to list original and additional authors.

Authors.adoc Format:
  The authors.adoc file contains author metadata in the following format:

    `:author_1:` FirstName{nbsp}MiddleName{nbsp}LastName  # Author's name with First, optional Middle and Last name.
    `:author_1_affiliation:` Organization Name            # The author's organizational affiliation.
    `:author_1_type:` original                            # (Optional) Specifies if the author is "original" or "additional" (default).
    `:author_1_orcid:` 0000-0002-1234-5678                # (Optional) ORCID identifier for the author.

Example of an authors.adoc file:
  `:author_1:` Doe{nbsp}John{nbsp}A.
  `:author_1_affiliation:` Example University
  `:author_1_type:` original

  `:author_2:` Smith{nbsp}Jane
  `:author_2_affiliation:` Research Institute

Notes:
  - Author names are split using `{nbsp}` to separate FirstName MiddleName LastName. MiddleName is optional.
  - The `type` specifies if the author is "original" or "additional". If this field is missing, it defaults to "additional".
  - ORCID is optional, but if available, it is included in the zenodo.json file.
"""

import re
import json
import sys
import os
import argparse
import yaml

def parse_authors_adoc(authors_adoc_path):
  """Parses the authors.adoc file to extract author metadata."""
  print(f"Parsing authors from: {authors_adoc_path}")
  authors = {"original": [], "additional": []}
  creators = []
  citation_authors = []

  if not os.path.exists(authors_adoc_path):
    print(f"Error: {authors_adoc_path} does not exist.")
    sys.exit(1)
    
  with open(authors_adoc_path, 'r') as file:
    content = file.read()
    
    author_ids = set(re.findall(r':author_(\d+):', content))
    
    for author_id in sorted(author_ids, key=int):
      author_data = {}
      
      name_match = re.search(rf':author_{author_id}: (.+)', content)
      if name_match:
        name_parts = name_match.group(1).split('{nbsp}')
        if len(name_parts) == 2:  # FirstName LastName
          first_name, last_name = name_parts
          given_names = first_name
          full_name = f"{first_name} {last_name}"
          zenodo_name = f"{last_name}, {first_name}"
        elif len(name_parts) == 3:  # FirstName MiddleName LastName
          first_name, middle_name, last_name = name_parts
          given_names = f"{first_name} {middle_name}"
          full_name = f"{first_name} {middle_name} {last_name}"
          zenodo_name = f"{last_name}, {first_name} {middle_name}"
        else:
          full_name = name_match.group(1).replace('{nbsp}', ' ')
          zenodo_name = name_match.group(1).replace('{nbsp}', ' ')
        
        author_data['family-names'] = last_name
        author_data['given-names'] = given_names
        author_data['name'] = full_name
        author_data['zenodo_name'] = zenodo_name
      
      affiliation_match = re.search(rf':author_{author_id}_affiliation: (.+)', content)
      if affiliation_match:
        author_data['affiliation'] = affiliation_match.group(1)
      
      orcid_match = re.search(rf':author_{author_id}_orcid: (.+)', content)
      if orcid_match:
        author_data['orcid'] = orcid_match.group(1)
      
      if 'name' in author_data and 'affiliation' in author_data:
        creator_entry = {
          "name": author_data['zenodo_name'],
          "affiliation": author_data['affiliation']
        }
        if 'orcid' in author_data:
          creator_entry['orcid'] = author_data['orcid']
        
        creators.append(creator_entry)
        
        author_entry = f"{author_data['name']}, {author_data['affiliation']}"
        authors['original' if re.search(rf':author_{author_id}_type: original', content) else 'additional'].append(author_entry)
        
        citation_authors.append({
          "affiliation": author_data['affiliation'],
          "family-names": author_data['family-names'],
          "given-names": author_data['given-names'],
          **({"orcid": author_data['orcid']} if 'orcid' in author_data else {})
        })
      else:
        print(f"Warning: Missing name or affiliation for author_{author_id}")
  
  #print(f"Total authors processed: {len(creators)} (Original: {len(authors['original'])}, Additional: {len(authors['additional'])})")
  return authors, creators, citation_authors


def generate_about_authors(adoc_output_path, authors):
  """Generates the about-authors.adoc file based on parsed authors."""
  content = ".Original Authors\n"
  for author in authors['original']:
    content += f"* {author}\n"
  
  content += "\n.Additional Authors\n"
  for author in authors['additional']:
    content += f"* {author}\n"
  
  #print(f"Writing about-authors.adoc to: {adoc_output_path}")
  with open(adoc_output_path, 'w') as file:
    file.write(content)
  print(f"{adoc_output_path} file written successfully with {len(authors['original'])} original authors and {len(authors['additional'])} additional authors.")


def update_zenodo_json(zenodo_json_path, creators):
  """Updates the creators section of zenodo.json with the parsed author data."""
  if not os.path.exists(zenodo_json_path):
    print(f"Error: {zenodo_json_path} does not exist.")
    sys.exit(1)
    
  #print(f"Updating zenodo.json file: {zenodo_json_path}")
  with open(zenodo_json_path, 'r') as file:
    zenodo_data = json.load(file)
  
  zenodo_data['metadata']['creators'] = creators

  with open(zenodo_json_path, 'w') as file:
    json.dump(zenodo_data, file, indent=2)
  print(f"{zenodo_json_path} file updated successfully with {len(creators)} authors.")

def update_citation_cff(citation_cff_path, citation_authors):
  """Updates the authors section of the CITATION.cff file."""
  if not os.path.exists(citation_cff_path):
    print(f"Error: {citation_cff_path} does not exist.")
    sys.exit(1)
    
  #print(f"Updating CITATION.cff file: {citation_cff_path}")
  with open(citation_cff_path, 'r') as file:
    citation_data = yaml.safe_load(file)
  
  citation_data['authors'] = citation_authors

  with open(citation_cff_path, 'w') as file:
    yaml.dump(citation_data, file, default_flow_style=False, sort_keys=False, indent=2)
  
  print(f"{citation_cff_path} file updated successfully with {len(citation_authors)} authors.")

def main():
  parser = argparse.ArgumentParser(
    description=__doc__,
    formatter_class=argparse.RawDescriptionHelpFormatter
  )
  parser.add_argument('--authors-adoc', default='authors.adoc', metavar='AUTHORS_ADOC_FILE', help='Path to the authors.adoc file (default: authors.adoc)')
  parser.add_argument('--update-zenodo', nargs='?', const='zenodo.json', metavar='ZENODO_FILE', help='Path to the zenodo.json file (default: zenodo.json)')
  parser.add_argument('--write-about-authors', nargs='?', const='about-authors.adoc', metavar='ABOUT_AUTHORS_FILE', help='Path to the about-authors.adoc file (default: about-authors.adoc)')
  parser.add_argument('--update-citation', nargs='?', const='CITATION.cff', metavar='CITATION_FILE', help='Path to the CITATION.cff file (default: CITATION.cff)')

  args = parser.parse_args()

#  print("Starting author update process...")
#  print(f"Authors file: {args.authors_adoc}")
#  print(f"Zenodo JSON file: {args.update_zenodo}")
#  print(f"About-Authors file: {args.write_about_authors}")
#  print(f"Citation CFF file: {args.write_about_authors}")
  
  authors, creators, citation_authors = parse_authors_adoc(args.authors_adoc)

  if args.write_about_authors:
    generate_about_authors(args.write_about_authors, authors)
  
  if args.update_zenodo:
    update_zenodo_json(args.update_zenodo, creators)

  if args.update_citation:
    update_citation_cff(args.update_citation, citation_authors)

#  print("\n--- Summary of Changes ---")
#  print(f"Total authors processed: {len(creators)}")
#  print(f"Original Authors: {len(authors['original'])}")
#  print(f"Additional Authors: {len(authors['additional'])}")
#  if args.write_about_authors:
#    print(f"About-Authors updated at: {args.write_about_authors}")
#  if args.update_zenodo:
#    print(f"Zenodo JSON updated at: {args.update_zenodo}")
#  if args.update_citation:
#    print(f"Citation CFF updated at: {args.update_zenodo}")
#  print("\n--- End of Summary ---")

if __name__ == "__main__":
  main()
