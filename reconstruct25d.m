%% read image, mask and show the resulting contour
fac = 1;
img = im2double(imresize(imread('klecks3_farbe.png'), fac));
mask = sum(im2double(imresize(imread('klecks3.png'),[size(img,1), size(img,2)])),3)<2.9999;
se = strel('disk',3);
mask = (imerode(mask,se));
figure, imshow(img-0.6*repmat(~mask, [1 1 3]).*img), hold on, contour(mask, [0.5 0.5], 'r-', 'linewidth', 3);
[ny,nx,nc] = size(img);

%% minimization 
nrOfUnknownEntries = sum(mask(:));
% volume of the reconstructed object:
vol = 20*nrOfUnknownEntries;
u = ones(nrOfUnknownEntries,1)/nrOfUnknownEntries*vol;

% implement your algorithm here

D = D_init(img);
D_small = D(:,mask(:));

u_large_matrix = double(mask*vol./sum(mask(:)));

u_k = u_large_matrix(:);

tau = 0.15;

iteration_number = 500
energy_output = zeros(iteration_number,1);

t = 1;
v = u_k;
v_small = v(mask(:));

for i = 1:iteration_number
    i
    [u_k1, energy]= grad_E_func(v_small, v, D , tau, vol ,mask);
    [v,t] = extrapolation_func(u_k1, u_k,t);
    u_k = u_k1;
    u = u_k1(mask(:));
    
 
    energy_output(i) = energy;
   
end 

%%
figure, plot(energy_output)


%% go back to full height image and illustrate the result
%u = 10 * log(1+u);
%u =  16 *(u.*(u>0)).^0.45;
heightImg = zeros(ny,nx);
heightImg(mask(:)==1)=u;
figure, imagesc(heightImg)

[x,y] = meshgrid(1:nx,1:ny);
figure, warp(x,y,heightImg,img-0.2*repmat(~mask, [1 1 3]).*img);
axis([1 nx 1 ny 0 max(u(:))*2])
axis equal
axis off;