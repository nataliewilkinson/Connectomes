addpath(genpath('C:\Users\nswso\OneDrive\Documents\MATLAB\BCT\'))

%% Control
myseq=0:0.05:0.5;
kmax=numel(myseq);
mydeg1=zeros(kmax, 332);
for k=1:kmax
    n=myseq(k);
CIJ1= csvread(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\'...
        ,'ControlVol_' , num2str(n), '.csv']);
  [id,od,deg1] = degrees_dir(CIJ1) ; 
  mydeg1(k,:)=deg1;
end
csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\',...
    'DEG1' ,'.csv'], mydeg1);

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

[h,p, ci, stats]= ttest2(mydeg1', mydeg2')


%% Hippocampus
hcNOS=mydeg1(:,51)
hcAD=mydeg2(:,51)
figure(1)
plot(myseq', hcNOS,'bo')
hold on
plot(myseq', hcAD,'r*')
hold off
title('Hippocampus')
% save image for this AND fimbria: (did it before but forget for images)...
% csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','Hippocampus.csv'], hcNOS);




%% Graphing Different Regions

myindex=[18 29 30 38 40 41 50 51 54 103 104 117 120 121 122 124 144 249 290] % continue it...
mylabels={'Cg32-R' , 'FrA-L', 'FrA-R', 'M1-R', 'M2-R', 'MO', 'S1BF-R', 'Hippocampus', ...
    'Primary Somatosensory Cortex-Forebrain', 'Dorsal Tenia Tecta-L', ...
    'Dorsal Tenia Tecta-R','Hypothalamus', 'Preoptic Telencephalon','121-Fimbria',...
    'Subthalamic Nucleus','Septum', 'Thalamus',...
    'Lateral Olfactory Tract', 'Superior Cerebellar Peduncle'} 
%actual names??- Fimbria 121?- names didn't match up on google form

for i=1:numel(myindex)
    
    hcNOS=mydeg1(:,myindex(i))
    hcAD=mydeg2(:,myindex(i))
figure(i)
plot(myseq', hcNOS,'bo')
hold on
plot(myseq', hcAD,'r*')
hold off

% Interpolation
xp=[0:0.01:0.5]
avg= (hcAD+hcNOS)./2
yp=interp1(myseq', avg, xp, 'linear')
hold on
plot(xp,yp,'m--')
hold off

% Title
mytitle=char(mylabels(i))
title(mytitle)

filename = strcat(mypath, mytitle, '.png'); 
print(filename,'-dpng','-r300');

end



%% To Do
% Look in BCT tool box to find global network properties
% then focus specifically on four regions
