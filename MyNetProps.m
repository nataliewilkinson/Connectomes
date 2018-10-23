addpath(genpath('C:\Users\nswso\OneDrive\Documents\MATLAB\BCT\'))

%% Control
myseq=0:0.05:0.5;
kmax=numel(myseq);
mydeg1=zeros(kmax, 332);
for k=1:kmax
    n=myseq(k);
CIJ1= csvread(['C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\'...
        ,'ControlVol_' , num2str(n), '.csv']);
  [id,od,deg1] = degrees_dir(CIJ1) ; 
  mydeg1(k,:)=deg1;
end
csvwrite(['C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\',...
    'DEG1' ,'.csv'], mydeg1);

%% AD
myseq=0:0.05:0.5;
mmax=numel(myseq);
mydeg2=zeros(mmax, 332);
for m=1:mmax
    n=myseq(m);
CIJ2= csvread(['C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\','ADVol_' , num2str(n), '.csv']);
  [id,od,deg2] = degrees_dir(CIJ2) ; 
  mydeg2(m,:)=deg2;
end
csvwrite(['C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\','DEG2' ,'.csv'], mydeg2);

[h,p, ci, stats]= ttest2(mydeg1', mydeg2')


%% Hippocampus
hcNOS=mydeg1(:,51)
hcAD=mydeg2(:,51)
figure(1)
plot(myseq', hcNOS,'bo')
hold on
plot(myseq', hcAD,'r*')
hold off
% save image for this AND fimbria: (did it before but forget for images)...
% csvwrite(['C:\Users\nswso\OneDrive\Documents\Research\CVNconnectivity\','Hippocampus.csv'], hcNOS);


%% Fimbria
hcNOS=mydeg1(:,121)
hcAD=mydeg2(:,121)
figure(2)
plot(myseq', hcNOS,'bo')
hold on
plot(myseq', hcAD,'r*')
hold off


%%
% Mission for next week: save the figures we have made and put them in a
% document- put the hippocampus and fimbria in a doc
% Look in BCT tool box to find global network properties
% then focus specifically on four regions
% permutation based statistics/ connectomes? understand