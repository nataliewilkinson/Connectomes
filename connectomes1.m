%% Covariance
%C=cov(V1,V2)
%% Pixel Graph
%call actual data from excel
Myfile='C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\NatMasterSheetCVN.xlsx';
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
csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','ControlVol.csv'],ControlVol);

AD100=corr(ADVol);
csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','ADVol.csv'],ADVol);

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


%% Remove bottom 10% of data.
%CTRL100
k=1
for n=0:.05:.5
    MyThresh1(k)=ceil((1-n)*(332*332-332))
    VCTRL100=CTRL100(:);
    [val1,myindex1]=sort(abs(VCTRL100), 'ascend');
    MyNewThresh1=VCTRL100(myindex1(1:MyThresh1(k)));
    R=find(abs(VCTRL100)>=max(MyNewThresh1));
    k=k+1
    VCTRL100_10=VCTRL100; 
    VCTRL100_10(R)=0;
    VCTRL100_10=reshape(VCTRL100_10,332,332);
    %figure(2+k)
    %imagesc(VCTRL100_10)
    mycolormap=jet(11)
    mycolormap(6, :)=[1 1 1]
    colormap(mycolormap)
    csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\'...
        ,'ControlVol_' , num2str(n), '.csv'],VCTRL100_10);
end

%AD100
m=1
for n=0:0.05:0.5
MyThresh2(m)=ceil((1-n)*(332*332-332))
VAD100=AD100(:);
[val2,myindex2]=sort(abs(VAD100), 'ascend');
MyNewThresh2=VAD100(myindex2(1:MyThresh2(m)));
R=find(abs(VAD100)>=max(MyNewThresh2));
m=m+1
VAD100_10=VAD100; 
VAD100_10(R)=0;
VAD100_10=reshape(VAD100_10,332,332);
figure(14+m)
imagesc(VAD100_10)
mycolormap=jet(11)
mycolormap(6, :)=[1 1 1]
colormap(mycolormap)
csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\'...
        ,'ADVol_' , num2str(n), '.csv'],VAD100_10);
end
