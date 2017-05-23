function main1()
im='crop1.jpg';
im2='crop2.jpg';
inputIm=imread(im);
refIm=imread(im2);
[t1,t2]=selectPoints(im,im2);
disp('Calculating homography matrix');
h = computeH(t1, t2);
disp('Image warping and stiching together');
figure;
[inputInRefFrame, mergeIm]=warpImage(inputIm,refIm,h);
