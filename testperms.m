clear all
deg1set=rand(50,10)
deg2set=rand(50,10)
 
deg2set(1,:)=deg2set(1,:)+0.5*std(deg2set(1,:))
p1=0;

numperms=(size(deg1set))
numperms=numperms(1)

for i=1:numperms
t(i)=mean(deg2set(i,:)-deg1set(i,:));
end

p=numel(find(t>t(1)))
p=p/numperms