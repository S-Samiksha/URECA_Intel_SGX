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
