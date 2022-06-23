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