function [ energy, dif ] = energy_func( u ,D_small, C, vol)
energy = 0;
dif = 0;
C = ones(size(u))

energy = sum(sqrt(C + (D_small*u).^2));
dif = abs(sum(u(:)) - vol);  

end