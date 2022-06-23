#!/bin/bash

rm -f output.txt
touch output.txt
rm -f log.txt
touch log.txt

testing(){
echo "-----------------------------------------" &>> ../output.txt
echo " " >> output.txt
echo " " >> output.txt
echo " " >> log.txt
echo " " >> log.txt
echo "-----------$1-------------------" &>> output.txt 
echo "-----------$1-------------------" &>> log.txt 
echo " " >> output.txt 
cd "$1"
source ../../environment 
make clean &>> ../log.txt
make SGX_MODE=SIM &>> ../log.txt


}

testing Test_1_Clflush
if (./app > /dev/null 2>&1) ; then 
	echo "No Segmentation Fault. Intel SGX SDK not successfully installed. There is a potential error" &>> ../output.txt
else
	echo "Resulted in Segmentation Fault. Hence, Intel SGX SDK is successfully installed" &>> ../output.txt
fi
echo " " &>> ../output.txt
cd ..


testing Test_2_Clflush
if (./app > /dev/null 2>&1) ; then 
	echo "No Error! Intel SGX SDK successfully installed." &>> ../output.txt
else
	echo "Resulted in Error. Hence, Intel SGX SDK is not successfully installed" &>> ../output.txt
fi
cd ..

testing Test_3_TAANG
if ./app > /dev/null  ; then 
	echo "No Illegal Instruction. TAA_NG is possible in this processor" &>> ../output.txt
else
	echo "Illegal Instruction! TAA_NG is not possible in this processor" &>> ../output.txt
	echo "TAA_NG, CacheOut, SGAxe, RIDL are not possible. " &>> ../output.txt
fi
cd ..

testing Test_4_FlushReload
if (./app > /dev/null 2>&1) ; then 
	echo "No Error! Flush and Reload on unprotected memory successful!" &>> ../output.txt
else
	echo "Error! Flush and Reload on unprotected memory not possible!" &>> ../output.txt
fi
cd ..

exec bash
