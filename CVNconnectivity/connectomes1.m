%% Covariance
%C=cov(V1,V2)
%% Pixel Graph
%call actual data from excel
Myfile='C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\NatMasterSheetCVN.xlsx'
% Extract Full Matrix
T=readtable(Myfile);
Tvars=T(3:end,2:end);
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
Indexcontrol=find(Genotype1Vars==1);
IndexAD=find(Genotype1Vars==2);
ControlVol= Tvars(:,Indexcontrol);
ControlVol=ControlVol';
ADVol=Tvars(:,IndexAD);
ADVol=ADVol';


CTRL100=corr(ControlVol);
csvwrite(['C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\','ControlVol.csv'],ControlVol);

AD100=corr(ADVol);
csvwrite(['C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\','ADVol.csv'],ADVol);

%% Plots
figure(1)
imagesc(CTRL100)
colormap(jet)
axis equal
colorbar
title('Correlation of Control Volumes')

figure(2)
imagesc(AD100)
colormap(jet)
axis equal
colorbar
title('Correlation of AD Volumes')


% Remove bottom 10% of data.
MyThresh=ceil((0.1)*(332*332-332))
VAD100=AD100(:);
[val,myindex]=sort(abs(VAD100), 'ascend');
MyNewThresh=VAD100(myindex(1:MyThresh));
R=find(abs(VAD100)<=max(MyNewThresh));
VAD100_10=VAD100; 
VAD100_10(R)=0;
VAD100_10=reshape(VAD100_10,332,332);
figure(3)
imagesc(VAD100_10)
mycolormap=jet(11)
mycolormap(6, :)=[1 1 1]
colormap(mycolormap)
% save as csv- important to do statistics on!
% make sure we are getting rid of the tails...


%attempting to graph histogram, find total area, then take 20% of it and
%replace it  [] so there is an empty matrix

%figure(1)
%histogram(CTRL100)
%figure(2)
%histogram(AD100)

%Y=CTRL100(:)
%TotAOC=trapz(Y)
%RemAOC=0.5*TotAOC
%R=find(CTRL100<=RemAOC)
%R=0