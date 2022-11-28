m.a_grid=linspace(p.a_min,p.a_max,p.naa);
[m.logZ,m.Pz]=Tauchen(p.mu_z,p.rho_z,p.sigma_z,p.nzz,p.m_z);
for ii=1:p.nzz
    m.z_grid(ii)=exp(m.logZ(ii));
end
m.z_grid=(m.z_grid-mean(m.z_grid))/std(m.z_grid)+1;
clear ii