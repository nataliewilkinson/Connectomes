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
allmyindices=[Indexcontrol, IndexAD];

ControlVol= Tvars(:,Indexcontrol);
ControlVol=ControlVol';
ADVol=Tvars(:,IndexAD);
ADVol=ADVol';
addpath(genpath('C:\Users\nswso\OneDrive\Documents\MATLAB\BCT\'))


% % %% Control
% % myseq=0:0.05:0.5;
% % kmax=numel(myseq);
% % mydeg1=zeros(kmax, 332);
% % for k=1:kmax
% %     n=myseq(k);
% % CIJ1= csvread(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\'...
% %         ,'ControlVol_' , num2str(n), '.csv']);
% %   [id,od,deg1] = degrees_dir(CIJ1) ; 
% %   mydeg1(k,:)=deg1;
% % end
% % csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\',...
% %     'DEG1' ,'.csv'], mydeg1);
% % 
% % mypath='C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\'
% % 
% % %% AD
% % myseq=0:0.05:0.5;
% % mmax=numel(myseq);
% % mydeg2=zeros(mmax, 332);
% % for m=1:mmax
% %     n=myseq(m);
% % CIJ2= csvread(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','ADVol_' , num2str(n), '.csv']);
% %   [id,od,deg2] = degrees_dir(CIJ2) ; 
% %   mydeg2(m,:)=deg2;
% % end
% % csvwrite(['C:\Users\natal\OneDrive - Duke University\Research\CVNconnectivity\','DEG2' ,'.csv'], mydeg2);
% % 
% % [h, p, ci, stats]= ttest2(mydeg1', mydeg2')
% % 
% % 
% % %% Hippocampus
% % hcNOS=mydeg1(:,51)
% % hcAD=mydeg2(:,51)
% % figure(1)
% % plot(myseq', hcNOS,'bo')
% % hold on
% % plot(myseq', hcAD,'r*')
% % hold off
% % title('Hippocampus')

%% Graphing Different Regions

myindex=[18 29 30 38 40 41 50 51 54 103 104 117 120 121 122 124 144 249 290] % continue it...
mylabels={'Cg32-R' , 'FrA-L', 'FrA-R', 'M1-R', 'M2-R', 'MO', 'S1BF-R', 'Hippocampus', ...
    'Primary Somatosensory Cortex-Forebrain', 'Dorsal Tenia Tecta-L', ...
    'Dorsal Tenia Tecta-R','Hypothalamus', 'Preoptic Telencephalon','Fimbria',...
    'Subthalamic Nucleus','Septum', 'Thalamus',...
    'Lateral Olfactory Tract', 'Superior Cerebellar Peduncle'} 
%actual names??- names didn't match up on google form

p1=0;
p2=0;
numperms=100 ;
NetThreshVals=[0.05:0.05:0.5];
degk1=zeros(1,numel(NetThreshVals));
degk2=zeros(1,numel(NetThreshVals));
for k=1:numel(NetThreshVals); %loop over net thresh
    NetThresh=NetThreshVals(k);
    [con1, con2, deg1, deg2]=PermConnectFunc(Tvars, Indexcontrol, IndexAD, NetThresh);
    tcan=abs(deg1-deg2)
    degk1(k)=deg1;
    degk2(k)=deg2;
    for i=1:numperms; %(eventually will go from 1:1000)
        g1=allmyindices(randperm(24, 11));
        g2=setdiff(allmyindices, g1);
        [con1, con2, deg1, deg2]=PermConnectFunc(Tvars, g1, g2, NetThresh);
        mydeg1=con1;
        mydeg2=con2;
    
            for j=8%:numel(myindex) %loop over regions
                % go through list plugging in the number regions in for j
                % to get the p-values for each region
                hcNOS=mydeg1(:,myindex(j));
                hcAD=mydeg2(:,myindex(j));
                 t=abs(deg1-deg2);   
                 
                  if t>tcan
                    p1=p1+1; %-
                  else 
                    p2=p2+1; %- 
                  end
                 p1total(k)=p1/numperms
            end

       
end


end


%% To Do
% Look in BCT tool box to find global network properties
% then focus specifically on four regions
