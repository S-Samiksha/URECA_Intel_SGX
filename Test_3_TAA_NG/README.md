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