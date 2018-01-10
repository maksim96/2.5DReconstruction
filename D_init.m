function [ D ] = D_init( img )
[n,m] = size(img(:,:,1));
e = ones(n,1);
f = ones(m,1);

Dy = spdiags([-e,e],[-1, 0], n, n);
Dy(1,1) = 0;

Dx = spdiags([f,-f], [0, 1], m, m);
Dx(1,1) = 0;

In = speye(n);
Im = speye(m);

D = [kron(Im,Dy);kron(Dx',In)];
end

