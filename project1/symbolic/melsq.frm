#include param.h
#include customfuncs.h


#include form-square/vars.h
#include customvars.h

Local Mphoton = vbar(fline1, p2)*i_*e*g(fline1, mu1)*u(fline1, p1) * (-i_*d_(mu1, mu2) * [photon prop]) * ubar(fline2, p4)*i_*(1/3*e)*g(fline2, mu2)*v(fline2, p3);
Local Mhiggs = vbar(fline1, p2)*(-i_*[gW/mW]*m(p1)/2)*u(fline1, p1) * (i_*[higgs prop]*(s - mH^2 + i_*wH*mH)) * ubar(fline2, p4)*(-i_*[gW/mW]*m(p3)/2)*v(fline2, p3);
Local Mz = vbar(fline1, p2)*(-i_*gZ/2)*((-1/2 + 2*sW^2)*g(fline1, mu1) + 1/2*g(fline1, mu1)*g(fline1, gIdx5))*u(fline1, p1) * (-i_)*(mZ^2*d_(mu1, mu2) - q(mu1)*q(mu2))*[z prop]*(s - mZ^2 + i_*wZ*mZ) * ubar(fline2, p4)*(-i_*gZ/2)*((-1/2 + 2/3*sW^2)*g(fline2, mu2) + 1/2*g(fline2, mu2)*g(fline2, gIdx5))*v(fline2, p3);

Global M = Mphoton + Mhiggs + Mz;
contract;

#if `DEBUG'
    Print;
#endif
.store;


#include form-square/matrix.frm


#include form-square/vars.h
#include customvars.h
Global MsqSimple = Msq;

id q = p1 + p2;

id p4 = p1 + p2 - p3;

id p1.p1 = m(p1)^2;
id p2.p2 = m(p2)^2;
id p3.p3 = m(p3)^2;
id p4.p4 = m(p4)^2;

id m(p1) = mMu;
id m(p2) = mMu;
id m(p3) = mB;
id m(p4) = mB;

id p1.p2 = (s - 2*mMu^2)/2;
id p1.p3 = (-t + mMu^2 + mB^2)/2;
id p2.p3 = (s + t - mMu^2 - mB^2)/2;

bracket t;
Print;
.end;
