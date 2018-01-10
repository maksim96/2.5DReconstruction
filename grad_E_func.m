function [ u_new, energy ] = grad_E_func(u, u_large_vector, D, tau, vol, mask)  
n = length(u_large_vector);
d = D*u_large_vector;

energy_temp = sqrt(sum(reshape(d, [n,2]).^2,2)+1);
energy = sum(energy_temp);

gradE = d./repmat(energy_temp,[2,1]);

gradE = D'*gradE;

mask = mask(:);
u_temp = (u_large_vector - tau*gradE).*mask;
u_new = projection_func(u_temp, u, vol, n, mask);

end
