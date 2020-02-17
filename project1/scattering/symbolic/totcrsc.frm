* returns indefinite integral of differential crossection

#include param.h
#include customfuncs.h


#include form-square/vars.h
#include customvars.h
Symbol n;

Local 
    #include `INPUTFILE'
Local totcrsc = t*3/4*1/64/s/PI/(s/4 - mMu^2)*`FROMNAME';
id t^n?pos_ = t^n/n;
#call restoreDenoms()
bracket t;

Print totcrsc;
.end
