#!/bin/bash
set -e # exit immediately if any command returns a non-zero exit code

nproc=${1:-"4"}

mpirun -n $nproc abinit gs.abi > gs.log 2> gs.err
mpirun -n $nproc abinit ebands.abi > ebands.log 2> ebands.err
mpirun -n $nproc abinit dfpt.abi > dfpt.log 2> dfpt.err

rm -f out_D*DB
mrgddb out_DDB dfpt*DDB.nc
mrgdv merge out_DVDB dfpt*POT*.nc

./clean.sh
