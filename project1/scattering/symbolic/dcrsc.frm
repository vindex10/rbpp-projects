#include param.h
#include customfuncs.h

#include form-square/vars.h
#include customvars.h

Local
    #include `INPUTFILE'
Local dcrsc = 3/4*1/64/s/PI/(s/4 - mMu^2)*`FROMNAME';
#call restoreDenoms()
bracket t;
Print dcrsc;
.end;
