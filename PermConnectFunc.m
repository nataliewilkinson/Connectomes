function[con1, con2, deg1, deg2]= PermConnectFunc(Tvars, g1, g2,NetThresh)
%csvfile contains the volumes at the particular threshold
%g1 is the membership for Nos2 based on permutations
%g2 is for cvns based on permutations
%con1 and con2 are the connectivty matrices for group1 and group2
%deg1 and deg2 are the number of non zero entries in con1 and con2, i.e.
%for gen1 and gen2

ControlVol= Tvars(:,g1);
ControlVol=ControlVol';
ADVol=Tvars(:,g2);
ADVol=ADVol';

CTRL100=corr(ControlVol);
%csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\\','ControlVol.csv'],ControlVol);
AD100=corr(ADVol);
%csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\\','ADVol.csv'],ADVol);

con1=CTRL100;
con2=AD100;

%% threshold connectomes
n=NetThresh
    MyThresh1=ceil((1-n)*(332*332-332));
    VCTRL100=con1(:);
    [val1,myindex1]=sort(abs(VCTRL100), 'ascend');
    MyNewThresh1=VCTRL100(myindex1(1:MyThresh1));
    R=find(abs(VCTRL100)>=max(MyNewThresh1));
    con1out=VCTRL100; 
    con1out(R)=0;
   con1out=reshape(con1out,332,332);
    
MyThresh2=ceil((1-n)*(332*332-332));
VAD100=con2(:);
[val2,myindex2]=sort(abs(VAD100), 'ascend');
MyNewThresh2=VAD100(myindex2(1:MyThresh2));
R=find(abs(VAD100)>=max(MyNewThresh2));
con2out=VAD100; 
con2out(R)=0;
con2out=reshape(con2out,332,332);


deg1=numel(find(abs(con1out)>0.50));
deg2=numel(find(abs(con2out)>0.50));
end
%% CHECK! Shouldn't have 12 values for threshold so don't index it? 
% Make parameters for permconnectfunc or connectperm to run at different
% threshold
% threshold correlations at p<0.05 