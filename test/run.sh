# nohup /usr/bin/time -v mpiexec -n 16 ./FANS input_files/3d0_MFL_0_mech.json &

nohup /usr/bin/time -v mpiexec --bind-to core -n 16 ./FANS input_files/test_MechLinear.json test_results.h5 > nohup.log 2>&1 &
# nohup /usr/bin/time -v mpiexec --bind-to core -n 8 ./FANS input_files/test_HyperElastic.json test_results.h5 > nohup.log 2>&1 &
# nohup /usr/bin/time -v mpiexec --bind-to core -n 16 ./FANS input_files/test_ThermalLinear.json test_results.h5 > nohup.log 2>&1 &
