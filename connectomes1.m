%% Covariance
%C=cov(V1,V2)
%% Pixel Graph
%call actual data from excel
A=randi(300, 300)
figure(1)
imagesc(corr(A))
colormap(jet)
axis equal
colorbar
%legends!