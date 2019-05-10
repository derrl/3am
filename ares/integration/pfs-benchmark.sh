#!/bin/bash

Threads=40
for i in {1..10}
do
mpirun  -np $Threads -hostfile ../benchmark-nodes ../IOR_main/ior_build/bin/ior -w -t 1m -b 16m -s 64 -o /mnt/nvme/hliu91/pvfs-shared/test -F -B -e -k >> ~/IOR_write_res_$Threads
sleep 1
rm /mnt/nvme/hliu91/pvfs-shared/test.00000*
sleep 1
done

#for i in {1..20}
#do
#mpirun  -np 5 -hostfile ../benchmark-nodes ../IOR_main/ior_build/bin/ior -w -t 1m -b 16m -s 64 -o /mnt/nvme/hliu91/pvfs-shared/test -F -B -e -k >> ~/IOR_write_res_5
#sleep 1
#rm /mnt/nvme/hliu91/pvfs-shared/test.00000*
#sleep 1
#done
#
#for i in {1..5}
#do
#mpirun  -np 10 -hostfile ../benchmark-nodes ../IOR_main/ior_build/bin/ior -w -t 1m -b 16m -s 64 -o /mnt/nvme/hliu91/pvfs-shared/test -F -B -e -k >> ~/IOR_write_res_10
#sleep 1
#rm /mnt/nvme/hliu91/pvfs-shared/test.00000*
#sleep 1
#done
#
#for i in {1..5}
#do
#mpirun  -np 20 -hostfile ../benchmark-nodes ../IOR_main/ior_build/bin/ior -w -t 1m -b 16m -s 64 -o /mnt/nvme/hliu91/pvfs-shared/test -F -B -e -k >> ~/IOR_write_res_20
#sleep 1
#rm /mnt/nvme/hliu91/pvfs-shared/test.00000*
#sleep 1
#done
#
#for i in {1..5}
#do
#mpirun  -np 40 -hostfile ../benchmark-nodes ../IOR_main/ior_build/bin/ior -w -t 1m -b 16m -s 64 -o /mnt/nvme/hliu91/pvfs-shared/test -F -B -e -k >> ~/IOR_write_res_40
#sleep 5
#rm /mnt/nvme/hliu91/pvfs-shared/test.00000*
#sleep 3
#done
#
#for i in {1..5}
#do
#mpirun  -np 8 -hostfile ../benchmark-nodes ../IOR_main/ior_build/bin/ior -w -t 1m -b 16m -s 64 -o /mnt/nvme/hliu91/pvfs-shared/test -F -B -e -k >> ~/IOR_write_res_8
#sleep 1
#rm /mnt/nvme/hliu91/pvfs-shared/test.00000*
#sleep 1
#done
#
#
#for i in {1..5}
#do
#mpirun  -np 16 -hostfile ../benchmark-nodes ../IOR_main/ior_build/bin/ior -w -t 1m -b 16m -s 64 -o /mnt/nvme/hliu91/pvfs-shared/test -F -B -e -k >> ~/IOR_write_res_16
#sleep 1
#rm /mnt/nvme/hliu91/pvfs-shared/test.00000*
#sleep 1
#done
#
#
#for i in {1..5}
#do
#mpirun  -np 32 -hostfile ../benchmark-nodes ../IOR_main/ior_build/bin/ior -w -t 1m -b 16m -s 64 -o /mnt/nvme/hliu91/pvfs-shared/test -F -B -e -k >> ~/IOR_write_res_32
#sleep 2
#rm /mnt/nvme/hliu91/pvfs-shared/test.00000*
#sleep 1
#done
#
