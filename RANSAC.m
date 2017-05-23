function [CollectLoc, CollectLoc2]=RANSAC(t1, t2,inputIm, refIm)
h = computeH(t1, t2);
[Rows1, Cols1, three]=size(inputIm);
[Rows2, Cols2, three]=size(refIm);
Location=[];
Location2=[];
CollectLoc=[];
CollectLoc2=[];
% below two parameters epsilon and N, number of random selected points are
% adjustable.
epsilon=1.0e+01;
N=1.0e+03;
for i =1:N
    Location(1,i)=randperm(Cols1,1);
    Location(2,i)=randperm(Rows1,1);
    Location2(1,i)=randperm(Cols2,1);
    Location2(2,i)=randperm(Rows2,1);
end
Location_ext=[Location;ones(1,N)];
L1=h*Location_ext;
L2=L1./L1(3,:);
L2=L2(1:2,:);
count=0;
for i=1:N%L2
    for j=1:N%Location2
        diff=L2(:,i)-Location2(:,j);
        SSD=diff(1)^2+diff(2)^2;
        if SSD< epsilon
            count=count+1;
            CollectLoc(1,count)=Location(1,i);
            CollectLoc(2,count)=Location(2,i);
            CollectLoc2(1,count)=Location2(1,j);
            CollectLoc2(2,count)=Location2(2,j);
        end
    end
    
end
subplot(1,2,1);
imshow(uint8(inputIm));
hold on;
plot(CollectLoc(1,:), CollectLoc(2,:),'b*');
subplot(1,2,2);
imshow(uint8(refIm));
hold on;
plot(CollectLoc2(1,:),CollectLoc2(2,:),'r*');

        
