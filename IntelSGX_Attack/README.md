## Introduction
In many applications, sensitive code needs to run on a higher security level than that of the operating system. These sensitive codes run on environments called the Trusted Execution Environments(TEE). One such TEE is the Intel Software Guard Extensions (SGX). SGX creates enclaves that are separated from the operating system and the hypervisor to ensure that the codes in the enclaves are protected.[1], [2]

The aim of this research is to replicate existing vulnerabilities in IntelSGX on the machine that is available in NTU's Hardware and Embedded Systems Laboratory. The machine being used is the Dell Optiplex 5080 MT/SFF equipped with the Intel **i5-10500 processor** (3.1GHz up to 4.5Ghz 12MB smart cache) with IntelSGX support. 

All of the codes work using a machine that supports IntelSGX. To download the SDK, refer to https://github.com/intel/linux-sgx. 

## Objective of this research 
To create a repository of possible attacks that can be carried out on intel processors that support Intel SGX. Additionally, this repository aims to automate regression testing such that when a new processor is to be tested, one simply needs to run the shell script. This repository is still work in progress and will be updated regularly. 




**References**
<br>
[1] P. Jain et al., “OpenSGX: An Open Platform for SGX Research,” Copyr. 2016 Internet Soc., Feb. 2016, doi: 10.14722/ndss.2016.23011.<br>
[2]	A. Nilsson, N. Bideh, and J. Brorsson, “A Survey of Published Attacks on Intel SGX,” Jun. 2020, Accessed: Oct. 25, 2021. [Online]. Available: https://arxiv.org/pdf/2006.13598.pdf.
