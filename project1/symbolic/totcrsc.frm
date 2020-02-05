* returns indefinite integral of differential crossection

#include param.h
#include customfuncs.h


#include form-square/vars.h
#include customvars.h
Symbol n;

Local 
    #include `INPUTFILE'
Local totcrsc = 1/4*1/64/s/PI/(s/4 - mMu^2)*`FROMNAME';
id t^n = t*t^n/(n+1);
#call restoreDenoms()

Print totcrsc;
.end
