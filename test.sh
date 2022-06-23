#!/bin/bash
echo "-----------Test_1_Clflush begins-------------------"
cd Test_1_Clflush
source /home/hesl/Desktop/sgxsdk/environment 
make clean
make SGX_MODE=SIM
./app
echo "-----------Test_1_Clflush completed----------------"
cd ..
echo "-----------Test_2_Clflush begins-------------------"
cd Test_2_Clflush
source /home/hesl/Desktop/sgxsdk/environment 
make clean
make SGX_MODE=SIM 
./app
echo "-----------Test_2_Clflush completed----------------"
cd ..
echo "------------Test_3_TAA_NG begins-------------------"
cd Test_3_TAA_NG
source /home/hesl/Desktop/sgxsdk/environment 
make clean
make SGX_MODE=SIM
./app
echo "-----------Test_3_TAA_NG completed-----------------"
cd ..
echo "-----------Test_4_Flush_Reload begins--------------"
cd Test_4_Flush_Reload
source /home/hesl/Desktop/sgxsdk/environment 
make clean
make SGX_MODE=SIM
./app
cd ..
echo "-----------Test_4_Flush_Reload completed-----------"
exec bash
