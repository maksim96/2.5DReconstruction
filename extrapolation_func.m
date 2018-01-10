function [ v, t_k1 ] = extrapolation_func(u_k1,u_k, t_k) 
t_k1 = (1 + sqrt(1 + 4*t_k^2))/2;

v = u_k1 + ((t_k -1)/t_k1).*(u_k1 - u_k);


end

