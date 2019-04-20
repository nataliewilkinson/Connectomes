%read in stats file
addpath('Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/fdr_bh.m') 
 addpath('/Volumes/CivmUsers/omega/Documents/MATLAB/alex/fdr_bh/')
%0 CVN; 1 is CTRL
genotype=[ 
1
];


allrunnos={  'N51124',  'N51130' ,'N51393','N51392','N51390', 'N51388','N51136', 'N51133' ,'N51282', 'N51234','N51201','N51241','N51252','N51383','N51386','N51231','N51404','N51406','N51221','N51193','N51221','N51182','N51151','N51131','N51164'}

if genotype==1 
    runnos=allrunnos(14:21)
    treatment='CTRL'
elseif genotype==0;
    runnos=runnos(22:end)
    treatment='WT'
else
 runnos=allrunnos(1:13)
 treatment='CVN';
end


path_in='/Volumes/cretespace/cvn_15dec2014_corrlabels/'; %'/Volumes/mf177/cluster_test/';
path_out='/Volumes/cretespace/cvn_15dec2014_corrlabels/stats/';

path_in='/Volumes/cretespace/alex/cvn_corrected_labels/'
path_out='/Volumes/cretespace/alex/cvn_corrected_labels/feb2015/'

runnos=allrunnos
age_mo=[20	21	18	18	18	18	16	16	16	14	14	11	11	17	17	15	14	14	14	14	12	15	15	16	15]
 

 
predictors=[2	29.3	88.1	2
2	28.5	94	2
2	33.1	78	2
2	34.8	78	2
2	37	78	2
2	30	78	2
1	59.4	68.7	2
1	28.7	68.7	2
1	33.7	68.9	2
2	29.7	61.7	2
2	27.9	61.7	2
1	28.1	50	2
1	37.4	48.3	2
1	40	75.4	1
1	49	75.4	1
1	33	67.7	1
2	33.1	62	1
2	23.2	62	1
1	33.9	62.7	1
2	29.9	62.7	1
2	39.9	63	1
2	30.5	65	0
1	33.7	63	0
2	28.9	68	0
1	35.5	68	0];




gender=predictors(:,1);
weight=predictors(:,2);
age=predictors(:,3);
genotype=predictors(:,4); %given here in the first lines, no need to

ind_outliers=''; %20;
genotype(ind_outliers)=-1;

TableAlx = table(gender,weight,age, genotype,runnos', 'VariableNames', {'Gender' 'Weight' 'Age' 'Genotype' 'Runno'});

%/Volumes/cretespace/cvn_15dec2014_corrlabels/dwi_labels_warp_N51383_crstats.txt  

for i=1:numel(runnos)
    runno=runnos{i}
    %path_in_labels_stats=[path_in];
    mystatsfile=[path_in 'dwi_labels_warp_' runno '_crstats.txt']
    T=0;
    T=readtable(mystatsfile,'HeaderLines',2,'Delimiter','\t');
%{file_labels_in,file_fa, file_e1,file_rd, file_e2, file_e3, file_adc,file_dwi }
  %standard order
%     vol(i,:)=T(:,3); %T.Var2;  
%     dwi(i,:)=T(:,4);% T.Var3;
%     fa(i,:)=T(:,5);%T.Var4;
%     e1(i,:)= T(:,6);%T.Var5;
%     e2(i,:)=T(:,7);%T.Var6;
%     e3(i,:)=T(:,8);%T.Var7;
%     rd(i,:)=T(:,9);%T.Var8;
%     adc(i,:)=T(:,10);%T.Var9;
    %hess order
    vol(i,:)=T.Var3; % T(:,3); %
    dwi(i,:)= T.Var4;%T(:,4);%
    fa(i,:)=T.Var5;%T(:,5);%
    e1(i,:)=T.Var6;% T(:,6);%
    e2(i,:)=T.Var7;%T(:,7);%
    e3(i,:)=T.Var8;%T(:,8);%
    rd(i,:)=T.Var9;%T(:,9);%
    adc(i,:)=T.Var10;%T(:,10);%
end

%path_out='/Volumes/cretespace/alex/cvn_corrected_labels/'

%dlmwrite([path_out,'vol.txt'], vol', 'delimiter', '\t', 'precision', '%10.8f', '-append','roffset', 1);
 
dlmwrite([path_out,'vol.txt'], vol, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'dwi.txt'], dwi, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'fa.txt'], fa, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'e1.txt'], e1, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'e2.txt'], e2, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'e3.txt'], e3, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'rd.txt'], rd, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
dlmwrite([path_out,'adc.txt'], adc, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);

dlmwrite([path_out,'predictors.txt'], predictors, 'delimiter', '\t', 'precision', '%10.8f'); %, '-append','roffset', 1);
writetable(TableAlx, [path_out,'predictors_table.txt'] , 'WriteRowNames',true)

prefix='all'; %'nooutlier'

ind1=intersect(find(genotype ==1 ),find(60<age & age<87)); %CTRL-NOS
ind2=intersect(find(genotype ==2 ),find(60<age & age<87)) ;%CVN

 
writemystats1(dwi(ind2,2:end)',dwi(ind1,2:end)',[path_out 'cvn_stats_dwi' prefix],0)
writemystats1(fa(ind2,2:end)',fa(ind1,2:end)',[path_out 'cvn_stats_fa' prefix ],0)
writemystats1(e1(ind2,2:end)',e1(ind1,2:end)',[path_out 'cvn_stats_e1' prefix ],0)
writemystats1(e2(ind2,2:end)',e2(ind1,2:end)',[path_out 'cvn_stats_e2' prefix],0)
writemystats1(e3(ind2,2:end)',e3(ind1,2:end)',[path_out 'cvn_stats_e3' prefix],0)
writemystats1(rd(ind2,2:end)',rd(ind1,2:end)',[path_out 'cvn_stats_rd' prefix ],0)
writemystats1(adc(ind2,2:end)',adc(ind1,2:end)',[path_out 'cvn_stats_adc' prefix ],0)
writemystats1(vol(ind2,2:end)',vol(ind1,2:end)',[path_out 'cvn_stats_vol' prefix],1)


%[h1,p1,ci1,stats1] = ttest2(fa(ind2,:),fa(ind1,:));

 
% T.Var2=volume
% T.Var3=DWI
% T.Var5=FA
% T.Var6=E1
% T.Var7=E2
% T.Var8=E3
% T.Var9=RD
% T.Var10=ADC