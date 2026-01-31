# WRAPs

![header.png](./header.png)

Water-soluble RFdiffused Amphipathic Proteins (WRAPs)

## Description
WRAPs (Water-soluble RFdiffused Amphipathic Proteins) are genetically encoded de novo proteins that surround the lipid-interacting hydrophobic surfaces of transmembrane proteins, rendering them thermostable and water-soluble without the need for detergents. This repo includes scripts and inputs to generate WRAPs as described in the [WRAPs paper](https://www.biorxiv.org/content/10.1101/2025.02.04.636539v1).

## Reference
Ljubica Mihaljević et. al. Membrane protein solubilization and structure determination using de novo-designed amphipathic proteins. Submitted to Science.

## Installation
You can install, setup, and run all the necessary software to generate WRAPs from the Google Colab Notebooks provided in this repo for [helical WRAPS](https://colab.research.google.com/github/davidekim/WRAPs/blob/main/helical_wraps.ipynb) and  [barrel WRAPS](https://colab.research.google.com/github/davidekim/WRAPs/blob/main/barrel_wraps.ipynb).

You can clone this repo into a preferred destination directory by going to that directory and then running:

`git clone https://github.com/davidekim/WRAPs.git`


### Dependencies

RFDiffusion https://github.com/RosettaCommons/RFdiffusion

Protein MPNN https://github.com/dauparas/ProteinMPNN

Alphafold2 https://github.com/google-deepmind/alphafold

dl_binder_design https://github.com/nrbennet/dl_binder_design

ppi_iterative_opt https://github.com/davidekim/ppi_iterative_opt


#### To generate parametric barrel WRAPs

sushimaki https://github.com/davidekim/sushimaki

parametric barrels https://github.com/davidekim/parametric_barrels


## Authors and acknowledgment
This work was conceptualized and developed by David Kim (dekim@uw.edu), Ljubica Mihaljevic (ljubim@uw.edu), and Pooja Bandawane (banda14@uw.edu)



