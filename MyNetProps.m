addpath(genpath('C:\Users\nswso\OneDrive\Documents\MATLAB\BCT\'))

%% Control
myseq=0:0.05:0.5;
kmax=numel(myseq);
mydeg1=zeros(kmax, 332);
for k=1:kmax
    n=myseq(k);
CIJ1= csvread(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\',...
    'ControlVol_' , num2str(n), '.csv']);
  [id,od,deg1] = degrees_dir(CIJ1) ; 
  mydeg1(k,:)=deg1;
end
csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','DEG1' ,'.csv'], mydeg1);

mypath='C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\'

%% AD
myseq=0:0.05:0.5;
mmax=numel(myseq);
mydeg2=zeros(mmax, 332);
for m=1:mmax
    n=myseq(m);
CIJ2= csvread(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','ADVol_' , num2str(n), '.csv']);
  [id,od,deg2] = degrees_dir(CIJ2) ; 
  mydeg2(m,:)=deg2;
end
csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','DEG2' ,'.csv'], mydeg2);

[h, p, ci, stats]= ttest2(mydeg1', mydeg2')


%% Graphing Different Regions
clf
myindex=[42 43 51 59 62 65 81 91 92 119 120 121 122 124]%[18 29 30 38 40 41 50 51 54 103 104 117 120 121 122 124 144 249 290] % continue it...
mylabels= {'Caudomedial Entorhinal Cortex', 'Dorsal Intermediate Entorhinal Cortex',...
    'Hippocampus', 'Hypothalamus', 'Septum', 'Amygdala', 'Superior Colliculus',...
    'Cerebellum', 'Dentate_Cerebellum',    'Optic Tracts', 'Fimbria',...
    'Corpus Callosum', 'Fornix', 'Cingulum'}

for i=1:numel(myindex)
    hcNOS=mydeg1(:,myindex(i))
    hcAD=mydeg2(:,myindex(i))
figure(i)
plot(myseq', hcNOS,'bo')
hold on
plot(myseq', hcAD,'r*')
hold off


% Interpolation
mydeg1new=mydeg1(:,i)
mydeg2new=mydeg2(:,i)
plot(myseq, mydeg1new, 'r.-')
hold on
plot(myseq,mydeg2new, 'b-o')
hold off


% Title
mytitle=char(mylabels(i))
title(mytitle)

filename = strcat(mypath, mytitle, '.png'); 
print(filename,'-dpng','-r300');

export_fig(mylabels(i), '-png', '-r200')
end



%% To Do
% Look in BCT tool box to find global network properties
% then focus specifically on four regions
