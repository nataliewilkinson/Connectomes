%% Pixel Graph
%call actual data from excel
Myfile='C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\NatMasterSheetCVN.xlsx';
% Extract Full Matrix
T=readtable(Myfile);
Tvars=T(3:end,2:end); %Volumes
Tvars=Tvars.Variables;
Tvars1=Tvars';
% Normalization...
TotVol=sum(Tvars,1); % sum of brain volumes for each subject
Tvars=100.*Tvars./repmat(TotVol,332,1);
% Extracting the Genotype
Genotype=T(:,2:end);
Genotype1=Genotype(1,:);
Genotype1Vars=Genotype1.Variables;

% Extract Connectomes for the two Groups
Indexcontrol=find(Genotype1Vars==1); % (g1)
IndexAD=find(Genotype1Vars==2); % (g2)
ControlVol= Tvars(:,Indexcontrol);
ControlVol=ControlVol';
ADVol=Tvars(:,IndexAD);
ADVol=ADVol';


CTRL100=corr(ControlVol);
csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','ControlVol.csv'],ControlVol);

AD100=corr(ADVol);
csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','ADVol.csv'],ADVol);






%% Determining P-Values
allmyindices=[Indexcontrol, IndexAD];

p1=0;
p2=0;
numperms=1000;
NetThreshVals=[0.05:0.01:0.25];
degk1=zeros(1,numel(NetThreshVals));
degk2=zeros(1,numel(NetThreshVals));
for k=1:numel(NetThreshVals);
    NetThresh=NetThreshVals(k);
    [con1, con2, deg1, deg2]=PermConnectFunc(Tvars, Indexcontrol, IndexAD, NetThresh);
tcan=abs(deg1-deg2)
degk1(k)=deg1;
degk2(k)=deg2;
for i=1:numperms %(eventually will go from 1:1000)
    g1=allmyindices(randperm(24, 11));
    g2=setdiff(allmyindices, g1);
    [con1, con2, deg1, deg2]=PermConnectFunc(Tvars, g1, g2, NetThresh);
    t=abs(deg1-deg2);
        if t>tcan
        p1=p1+1; %-
    else 
        p2=p2+1; %- 
        
        end
end
p1total(k)=p1/numperms
%p2total(k)=p2/numperms
% shouldn't be getting large numbers...
end
%Get rid of diagonal element in connectome 1. 
save('degk1')
save('degk2')
