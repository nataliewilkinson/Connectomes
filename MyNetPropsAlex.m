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


%% Graphing Different Regions
myindex=[42 43 51 59 62 65 81 91 92 119 120 121 122 124]
mylabels= {'Caudomedial Entorhinal Cortex', 'Dorsal Intermediate Entorhinal Cortex',...
    'Hippocampus', 'Hypothalamus', 'Septum', 'Amygdala', 'Superior Colliculus',...
    'Cerebellum', 'Dentate_Cerebellum',    'Optic Tracts', 'Fimbria',...
    'Corpus Callosum', 'Fornix', 'Cingulum'}


p1=0;
p2=0;
p1r=0;
p2r=0;
numperms=100 ;
NetThreshVals=[0.05:0.05:0.5];
pparametrictotal=zeros( 332,numel(NetThreshVals))

degk1=zeros(1,numel(NetThreshVals));
degk2=zeros(1,numel(NetThreshVals));

for j=1:numel(myindex) %index of region
for k=1:numel(NetThreshVals); %loop over net thresh
    NetThresh=NetThreshVals(k);
    [con1, con2, deg1, deg2]=PermConnectFunc(Tvars, Indexcontrol, IndexAD, NetThresh);
    tcan=abs(deg1-deg2)
%number of non zero entries in teh correlation matrices - global values
    degk1(k)=deg1;
    degk2(k)=deg2;
    %global degrees
   
    
    
   %for i=1:numperms; %(eventually will go from 1:1000)
%         g1=allmyindices(randperm(24, 11));
%         g2=setdiff(allmyindices, g1);
%         [con1, con2, deg1, deg2]=PermConnectFunc(Tvars, g1, g2, NetThresh);
      %  mydeg1=con1;
      %  mydeg2=con2;
       
    
            %for j=1:1; %numel(myindex) %loop over regions
               
                % go through list plugging in the number regions in for j
                % to get the p-values for each region
hcNOS=con1(:,myindex(j));
hcAD=con2(:,myindex(j));
%tcanregion(myindex(j))=numel(find(hcNOS))-numel(find(hcAD));
%                 tregion(myindex(j))=numel(find(hcNOS))-numel(find(hcAD))
%                 t=abs(deg1-deg2);   %global degree
%                  
%                   if t>tcan
%                     p1=p1+1; %-
%                   else 
%                     p2=p2+1; %- 
%                   end
%                  p1total(k)=p1/numperms
%                  
%                  if tregion>tcanregion
%                     p1r=p1r+1; %-
%                   else 
%                     p2r=p2r+1; %- 
%                   end
%                  p1totalregion(k)=p1r/numperms
                 
                 
           % end

       
%end

 [h pparametrictotal(myindex(j),k) ci stats]=ttest(hcNOS',hcAD');
end
end
 [h pparam ci stats]=ttest(degk1,degk2) ; 


%% To Do
% Look in BCT tool box to find global network properties
% then focus specifically on four regions
