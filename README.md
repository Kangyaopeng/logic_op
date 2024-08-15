# logic_op
a simple ut UVM env with svt apb vip

# pre-requirement
  SVT APB VIP is needed for this tb running

  The Default vip install path is "/common/dw_vip"

  If your vip not install at this path, you can modify the Path in Makefile line 2~3

# How to run?
  cd /dv/simulation/verif_env/ut

  Run simulation:

    make

  open waveform:

    verdi -ssf *fsdb &

  clean the directort:

    make clean

# Purpose
  learning how to use SVT_APB VIP, and how to build a ut UVM TB
