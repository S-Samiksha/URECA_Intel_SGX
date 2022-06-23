## Introduction
In many applications, sensitive code needs to run on a higher security level than that of the operating system. These sensitive codes run on environments called the Trusted Execution Environments(TEE). One such TEE is the Intel Software Guard Extensions (SGX). SGX creates enclaves that are separated from the operating system and the hypervisor to ensure that the codes in the enclaves are protected.[1], [2]

The aim of this research is to replicate existing vulnerabilities in IntelSGX on the machine that is available in NTU's Hardware and Embedded Systems Laboratory. The machine being used is the Dell Optiplex 5080 MT/SFF equipped with the Intel **i5-10500 processor** (3.1GHz up to 4.5Ghz 12MB smart cache) with IntelSGX support. 

All of the codes work using a machine that supports IntelSGX. To download the SDK, refer to https://github.com/intel/linux-sgx. 

## Objective of this research 
To create a repository of possible attacks that can be carried out on intel processors that support Intel SGX. Additionally, this repository aims to automate regression testing such that when a new processor is to be tested, one simply needs to run the shell script. This repository is still work in progress and will be updated regularly. 

## Overview of the Github
This repository provides both Non Intel SGX attacks and Intel SGX attacks. The attacks are in a tar file. The purpose of each attack is provided. 

### Non Intel SGX Attacks 

### Intel SGX Attacks 
------------------------
Purpose of Test_1_Clflush
------------------------
The code was copied from the cacheout research paper provided in [here](https://cacheoutattack.com/files/CacheOut.pdf). For easy reference here is the code:


```assembly
clflush (%rdi);
clflush (%rsi);
xbegin abort;
movq (%rdi), %rax;
shl $12, %rax;
andq $0xff00, %rax;
movq (%rax, %rsi), %rax ;
movq (%rcx), %rax ;
movq (%rcx), %rax ;
xend;

```

The above code was adapted and only the first two lines were used:

```assembly
clflush (%rdi);
clflush (%rsi);
```


The `clflush` instruction alone does not work within the SGX enclave. But only works **outside** the enclave. This could be due to the protected memory within Intel SGX that does not allow the `clflush` instruction to dump contents of the cache into shared memory. 

------------------------
Purpose of Test_2_Clflush
------------------------

Following Test 1, this is simply to test the `clflush` instruction outside of enclave execution. This should work normally causing no errors. 

------------------------
Purpose of Test_3_TAA_NG
------------------------

The code was copied from the cacheout research paper provided in [here](https://cacheoutattack.com/files/CacheOut.pdf). For easy reference here is the code:


```assembly
xbegin abort;
movq (%rdi), %rax;
shl $12, %rax;
andq $0xff00, %rax;
movq (%rax, %rsi), %rax ;
movq (%rcx), %rax ;
movq (%rcx), %rax ;
xend;

```

It is realized that the `xbeing abort` and `xend` only works on processors that has TSX enabled. In the current machine that we have, these instructions will result in an illegal instruction. 

------------------------
Purpose of Flush_Reload 
------------------------

This particular code was updated from [here](https://github.com/jovanbulck/sgx-tutorial-space18/tree/master/003-sgx-flush-and-reload). This particular code is only for unprotected memory within the sgx enclave.

Due to the nature of flush+reload using cache flush, it is not possible to run a flush+reload for an enclave you do not have access to. This is the [USENIX PAPER](https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-paper-yarom.pdf). In this paper, we see this particular code:

```c++
 int probe(char *adrs) {
volatile unsigned long time;
asm __volatile__ (
 " mfence \n"
 " lfence \n"
 " rdtsc \n"
 " lfence \n"
 " movl %%eax, %%esi \n"
 " movl (%1), %%eax \n"
 " lfence \n"
 " rdtsc \n"
 " subl %%esi, %%eax \n"
 " clflush 0(%1) \n" 
 : "=a" (time)
 : "c" (adrs)
 : "%esi", "%edx");
 return time < threshold;
}

```
This may not be possible within the SGX Enclave due to clflush not working as shown earlier in test 1. Additionally, it is quoted in this [paper](https://arxiv.org/pdf/1802.09085.pdf) that clflush is not possible as we cannot access memory that belongs to an enclave from the outside. 




**References**
<br>
[1] P. Jain et al., “OpenSGX: An Open Platform for SGX Research,” Copyr. 2016 Internet Soc., Feb. 2016, doi: 10.14722/ndss.2016.23011.<br>
[2]	A. Nilsson, N. Bideh, and J. Brorsson, “A Survey of Published Attacks on Intel SGX,” Jun. 2020, Accessed: Oct. 25, 2021. [Online]. Available: https://arxiv.org/pdf/2006.13598.pdf.
