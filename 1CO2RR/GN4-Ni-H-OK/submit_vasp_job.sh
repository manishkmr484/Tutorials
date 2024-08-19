#!/bin/sh
#PBS -V
#PBS -N job
#PBS -q normal
#PBS -A etc
#PBS -l select=1:ncpus=64:mpiprocs=32:ompthreads=1
#PBS -l walltime=12:00:00
#PBS -e myjob.err
#PBS -A vasp

module purge
module load craype-mic-knl intel/oneapi_21.2 impi/oneapi_21.2 hdf5/1.10.2 fftw_mpi/3.3.7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home01/e1490a01/software/vasp.6.4.1/bin/dftd4/lib64

cd $PBS_O_WORKDIR
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo This jobs runs on the following processors:
echo `cat $PBS_NODEFILE`
cat $PBS_NODEFILE > mf.$PBS_JOBID
# Define number of processors
NPROCS=`wc -l < $PBS_NODEFILE`
echo This job has allocated $NPROCS nodes

/apps/compiler/intel/18.0.3/impi/2018.3.222/bin64/mpirun -np 32 /home01/e1490a01/software/vasp.6.4.1/bin/vasp_std > vasp.log 

