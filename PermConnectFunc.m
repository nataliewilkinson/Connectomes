function[con1, con2, deg1, deg2]= PermConnectFunc(Tvars, g1, g2)
%csvfile contains the volumes at the particular threshold
%g1 is the membership for Nos2 based on permutations
%g2 is for cvns based on permutations

ControlVol= Tvars(:,g1);
ControlVol=ControlVol';
ADVol=Tvars(:,g2);
ADVol=ADVol';

CTRL100=corr(ControlVol);
%csvwrite(['C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\','ControlVol.csv'],ControlVol);
AD100=corr(ADVol);
%csvwrite(['C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\','ADVol.csv'],ADVol);

con1=CTRL100;
con2=AD100;

%%%threshold connectomes
    k=1
%for n=0:.05:.5
n=0.25
    MyThresh1(k)=ceil((1-n)*(332*332-332));
    VCTRL100=con1(:);
    [val1,myindex1]=sort(abs(VCTRL100), 'ascend');
    MyNewThresh1=VCTRL100(myindex1(1:MyThresh1(k)));
    R=find(abs(VCTRL100)>=max(MyNewThresh1));
    con1out=VCTRL100; 
    con1out(R)=0;
   con1out=reshape(con1out,332,332);
    %end 
    m=k
MyThresh2(m)=ceil((1-n)*(332*332-332));
VAD100=con2(:);
[val2,myindex2]=sort(abs(VAD100), 'ascend');
MyNewThresh2=VAD100(myindex2(1:MyThresh2(m)));
R=find(abs(VAD100)>=max(MyNewThresh2));
con2out=VAD100; 
con2out(R)=0;
con2out=reshape(con2out,332,332);
%k=k+1
   %end threshold connectomes
deg1=numel(find(con1out));
deg2=numel(find(con2out));
end
%% CHECK! Shouldn't have 12 values for threshold so don't index it? 
% Make parameters for permconnectfunc or connectperm to run at different
% threshold
% threshold correlations at p<0.05 