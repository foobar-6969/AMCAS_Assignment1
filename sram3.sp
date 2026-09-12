* AMCAS TakeHomeLab - 6T read, bitline discharge and margin
.include 45nm_HP.pm
$ PTM BSIM4 card
.param VDD=1.1 VBL=1.1
Vdd vdd 0 'VDD'
Vwl wl 0 PWL(0 0 1n 0 1.05n 'VDD')
MP1 qb q vdd vdd pmos W=0.15u L=0.045u
MN1 qb q 0 0 nmos W=0.20u L=0.045u
MP2 q qb vdd vdd pmos W=0.15u L=0.045u
MN2 q qb 0 0 nmos W=0.20u L=0.045u
MA1 bl wl q 0 nmos W=0.16u L=0.045u
MA2 blb wl qb 0 nmos W=0.16u L=0.045u
Cbl bl 0 1.8p IC='VBL'
Cblb blb 0 1.8p IC='VBL'
.ic v(q)=0 v(qb)='VDD'
.control
  foreach vddval 1.10 1.05 1.00 0.95 0.90 0.85 0.80 0.75 0.70 0.65 0.60

  alterparam VDD = $vddval
  alterparam VBL = $vddval

  reset
  tran 5p 4n uic
  let delta_v = v(blb)-v(bl)
  meas tran dv FIND delta_v AT=2.0n
  meas tran qmax MAX v(q) FROM=1n TO=4n
  meas tran qend FIND v(q) AT=4.0n

  echo "VDDMARK $vddval"
  end
.endc
.end
