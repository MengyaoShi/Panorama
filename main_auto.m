function main_auto()
im='wdc1.jpg';
im2='wdc2.jpg';
inputIm=imread(im);
refIm=imread(im2);
[t1,t2]=AutoSelectPoints(im,im2);
disp('Calculating homography matrix');
h = computeH(t1, t2);
disp('Image warping and stiching together');
figure;
[inputInRefFrame, mergeIm]=warpImage(inputIm,refIm,h);

points1=t1;
points2=t2;
save('points.mat','points1', 'points2');