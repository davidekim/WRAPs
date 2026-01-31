# WRAPs

![header.png](./header.png)

Water-soluble RFdiffused Amphipathic Proteins (WRAPs)

## Description
WRAPs (Water-soluble RFdiffused Amphipathic Proteins) are genetically encoded de novo proteins that surround the lipid-interacting hydrophobic surfaces of transmembrane proteins, rendering them thermostable and water-soluble without the need for detergents. This repo includes scripts and inputs to generate WRAPs as described in the [WRAPs paper](https://www.biorxiv.org/content/10.1101/2025.02.04.636539v1).

## Reference
Ljubica Mihaljević et. al. Membrane protein solubilization and structure determination using de novo-designed amphipathic proteins. Submitted to Science.

## Table of Contents

* [Installation](#install)
  * [Submodules](#subs)
  * [Dependencies/Environment set up](#deps)
* [Generating WRAPs](#wraps)
* [Authors and acknowledgment](#auths)


## Installation <a name="install"></a>
You can install, set up, and run all the necessary software to generate WRAPs from the Google Colab Notebooks provided in this repo for [helical WRAPs](https://colab.research.google.com/github/davidekim/WRAPs/blob/main/helical_wraps.ipynb) and  [barrel WRAPs](https://colab.research.google.com/github/davidekim/WRAPs/blob/main/barrel_wraps.ipynb).

Alternatively, you can clone this repo into a preferred destination directory by going to that directory and then running:

`git clone https://github.com/davidekim/WRAPs.git`

### Submodules <a name="subs"></a>

RFDiffusion https://github.com/RosettaCommons/RFdiffusion

Protein MPNN https://github.com/dauparas/ProteinMPNN

dl_binder_design https://github.com/nrbennet/dl_binder_design

ppi_iterative_opt https://github.com/davidekim/ppi_iterative_opt

#### To generate parametric barrel WRAPs

sushimaki https://github.com/davidekim/sushimaki

parametric barrels https://github.com/davidekim/parametric_barrels


Install submodules by running:

~~~
cd WRAPs
git submodule init
git submodule update --remote
~~~

Download RFDiffusion model weights.
~~~
cd RFdiffusion
mkdir models && cd models
wget http://files.ipd.uw.edu/pub/RFdiffusion/6f5902ac237024bdd0c176cb93063dc4/Base_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/e29311f6f1bf1af907f9ef9f44b8328b/Complex_base_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/60f09a193fb5e5ccdc4980417708dbab/Complex_Fold_base_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/74f51cfb8b440f50d70878e05361d8f0/InpaintSeq_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/76d00716416567174cdb7ca96e208296/InpaintSeq_Fold_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/5532d2e1f3a4738decd58b19d633b3c3/ActiveSite_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/12fc204edeae5b57713c5ad7dcb97d39/Base_epoch8_ckpt.pt
cd ../../
~~~

Download AlphaFold2 model weights. 
~~~
cd dl_binder_design/af2_initial_guess
mkdir -p model_weights/params && cd model_weights/params
wget https://storage.googleapis.com/alphafold/alphafold_params_2022-12-06.tar
tar --extract --verbose --file=alphafold_params_2022-12-06.tar 
cd ../../../../ppi_iterative_opt/af2_initial_guess
ln -s ../../dl_binder_design/af2_initial_guess/model_weights/params .
cd ../../
~~~

Install ppi_iterative_opt RFdiffusion checkpoint.
~~~
cd ppi_iterative_opt/rf_diffusion
mkdir models && cd models
wget https://files.ipd.uw.edu/pub/ppi_iterative_opt/rf_diffusion/models/BFF_4.pt
cd ../../../
~~~

### Dependencies/Environment set up <a name="deps"></a>

~~~
pip install jedi omegaconf hydra-core icecream pyrsistent pynvml decorator
pip install git+https://github.com/NVIDIA/dllogger#egg=dllogger
pip install --no-dependencies dgl -f https://data.dgl.ai/wheels/torch-2.4/cu124/repo.html
pip install --no-dependencies e3nn==0.5.5 opt_einsum_fx
pip install biopython==1.81
pip install -U dm-haiku
pip install ml-collections
pip install --upgrade "jax[cuda12_pip]<0.6.0" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
cd RFdiffusion/env/SE3Transformer; pip install .; cd ../../; pip install -e .; cd ../
pip install --upgrade pybiolib
pip install pyrosetta --find-links https://west.rosettacommons.org/pyrosetta/quarterly/release
os.environ["DGLBACKEND"] = "pytorch"
~~~


## Generating WRAPs <a name="wraps"></a>
We recommend using the Google Colab Notebooks provided in this repo for [helical WRAPs](https://colab.research.google.com/github/davidekim/WRAPs/blob/main/helical_wraps.ipynb) and  [barrel WRAPs](https://colab.research.google.com/github/davidekim/WRAPs/blob/main/barrel_wraps.ipynb). For a general method that makes WRAPs parametrically around a target protein you can use the [sushimaki](https://colab.research.google.com/github/davidekim/sushimaki/blob/main/sushimaki.ipynb) Google Colab Notebook. 

For reproducing designs presented in the [WRAPs paper](https://www.biorxiv.org/content/10.1101/2025.02.04.636539v1), this repo provides directories containing inputs and commands to run RFdiffusion inference to generate backbone WRAPs and WRAPed designs for each target. For all targets, with the exception of MspA which uses tied positions to enforce symmetry at the MPNN sequence design stage, the [previously described](https://www.nature.com/articles/s41467-023-38328-5) protein binder design pipeline, [dl_binder_design](https://github.com/nrbennet/dl_binder_design), was used on each RFDiffused backbone for sequence design and Alphafold2 structure prediction validation. The script to run tied MPNN on WRAPed MspA RFDiffused backbones is provided in this repo.


## Authors and acknowledgment <a name="auths"></a>
This work was conceptualized and developed by David Kim (dekim@uw.edu), Ljubica Mihaljevic (ljubim@uw.edu), and Pooja Bandawane (banda14@uw.edu)



