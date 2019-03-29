%% Loading Data Files
AD100=abs(csvread('AD100.csv'));
CTRL100=abs(csvread('CTRL100.csv'));

%% Clustering Coefficient
ccAD=clustering_coef_wd(AD100)
ccCNTRL=clustering_coef_wd(CTRL100)

%% Global Efficiency
geAD=efficiency_wei(AD100, 0)
geCNTRL=efficiency_wei(CTRL100, 0) 

