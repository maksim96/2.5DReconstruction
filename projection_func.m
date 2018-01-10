function [ u_projected ] = projection_func( u_temp, u_small_vector, vol, n, mask )

u_projected = u_temp -((sum(u_temp) - vol)/length(u_small_vector))*mask;

end

