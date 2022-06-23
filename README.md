## Overview of the Github
This repository provides both Non Intel SGX attacks and Intel SGX attacks. The attacks are in a tar file. The purpose of each attack is provided. 

### Non Intel SGX Attacks 
Two versions,[1](https://github.com/chaitanyarahalkar/Spectre-PoC) and [2](https://github.com/crozone/SpectrePoC), of the Spectre Attacks were found. 
Both these attacks required no additional adaptation to the Intel Processor we were using. 

For codes running outside of Intel SGX enclaves, they are susceptible to cache attacks. Here is a [repository](https://github.com/IAIK/cache_template_attacks) that allows us to know whether the processor is susceptible to the cache attacks or not. 

### Intel SGX Attacks 


**Purpose of Test_1_Clflush** <br>

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

The above code was adapted and only the first two lines were used to test whether these instructions worked or not:

```assembly
clflush (%rdi);
clflush (%rsi);
```


The `clflush` instruction alone does not work within the SGX enclave. But only works **outside** the enclave. This could be due to the protected memory within Intel SGX that does not allow the `clflush` instruction to dump contents of the cache into shared memory. 


**Purpose of Test_2_Clflush** <br>


Following Test 1, this is simply to test the `clflush` instruction outside of enclave execution. This should work normally causing no errors. 

**Purpose of Test_3_TAA_NG** <br>

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

**Purpose of Flush_Reload** <br>

This particular code was adapted from [here](https://github.com/jovanbulck/sgx-tutorial-space18/tree/master/003-sgx-flush-and-reload). This particular code is only for unprotected memory within the SGX enclave.

This is the [USENIX PAPER](https://www.usenix.org/system/files/conference/usenixsecurity14/sec14-paper-yarom.pdf). In this paper, we see this particular code:

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


### Test Demo Video
This shows all the output provided by the tests. The latest `test.sh` script allows us to obtain an output file that gives us a direct interpretation of the tests. 


**References**
<br>
[1] P. Jain et al., “OpenSGX: An Open Platform for SGX Research,” Copyr. 2016 Internet Soc., Feb. 2016, doi: 10.14722/ndss.2016.23011.<br>
[2]	A. Nilsson, N. Bideh, and J. Brorsson, “A Survey of Published Attacks on Intel SGX,” Jun. 2020, Accessed: Oct. 25, 2021. [Online]. Available: https://arxiv.org/pdf/2006.13598.pdf.
