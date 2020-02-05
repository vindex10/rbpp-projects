* define number of fermionic lines (minimal)
#define LINES "2"

* define number of lorentz indices being used in M
#define LORENTZIDXNUM "10"


* include required variables, see descriptions in the vars.h
#include form-square/vars.h
* define custom symbols (irrelevant to Tr(M^2) computation) used in M
#include customvars.h
* define matrix element
Local Mphoton = vbar(fline1, p2)*i_*e*g(fline1, mu1)*u(fline1, p1) * (-i_*d_(mu1, mu2) * [photon prop]) * ubar(fline2, p4)*i_*e*g(fline2, mu2)*v(fline2, p3);
Local Mhiggs = vbar(fline1, p2)*(-i_*[gW/mW]*m(p1))*u(fline1, p1) * (i_*[higgs prop]) * ubar(fline2, p4)*(-i_*[gW/mW]*m(p3))*v(fline2, p3);
Local Mz = vbar(fline1, p2)*(-i_*gZ/2)*((-1/2 + 2*sW^2)*g(fline1, mu1) + 1/2*g(fline1, mu1)*g(fline1, gIdx5))*u(fline1, p1) * (-i_)*(q.q*d_(mu1, mu2) - q(mu1)*q(mu2))*[z prop] * ubar(fline2, p4)*(-i_*gZ/2)*((-1/2 + 2/3*sW^2)*g(fline2, mu2) + 1/2*g(fline2, mu2)*g(fline2, gIdx5))*v(fline2, p3);
Global M = Mphoton + Mhiggs + Mz;

* contract possible einstein symbols (eliminates metric tensor for instance, if possible)
contract;

Print;
.store;


* load this to compute Tr(M^2). Result is saved to Msq
#include form-square/matrix.frm
* NOTE: .end command is not called inside. If you want to stop here, call it below:


* include required variables, see descriptions in the vars.h
#include form-square/vars.h
* define custom symbols (irrelevant to Tr(M^2) computation) used in M
#include customvars.h
Symbol mE, mMu;
Symbol s, t;

Local res = Msq;

id q = p1 + p2;

id p4 = p1 + p2 - p3;

id p1.p1 = m(p1)^2;
id p2.p2 = m(p2)^2;
id p3.p3 = m(p3)^2;
id p4.p4 = m(p4)^2;

id m(p1) = mE;
id m(p2) = mE;
id m(p3) = mMu;
id m(p4) = mMu;

id p1.p2 = s - 2*mE^2;
id p1.p3 = -t + mE^2 + mMu^2;
id p2.p3 = s + t - mE^2 - mMu^2;

bracket t;

Print;
.end
