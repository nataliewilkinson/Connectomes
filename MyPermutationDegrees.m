% compare whole connectomes
AD_Hc_con=csvread('C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\ADVol_0.5.csv');
NOS_Hc_con=csvread('C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\ControlVol_0.5.csv');

mysize=size(AD_Hc_con);
nrows=mysize(1);
ncols=mysize(2);

AD_Hc_con=reshape(AD_Hc_con,nrows*ncols,1);
NOS_Hc_con=reshape(NOS_Hc_con,nrows*ncols,1);

% only works if you can fit groups directly- but I don't think we can. 
myperms=1000;
[p, observeddifference, effectsize] = permutationTest(AD_Hc_con, NOS_Hc_con, myperms)
