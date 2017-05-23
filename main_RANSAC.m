function main_RANSAC()
%Notice, you only need to choose four poits for RANSAC when you are asked to select points.
im='mountain1.png';
im2='mountain2.png';
[t1,t2]=selectPoints(im,im2);
inputIm=imread(im);
refIm=imread(im2);

[CollectLoc, CollectLoc2]=RANSAC(t1, t2,inputIm, refIm);
h = computeH(CollectLoc, CollectLoc2);
disp('Image warping and stiching together');
figure;
[inputInRefFrame, mergeIm]=warpImage(inputIm,refIm,h);