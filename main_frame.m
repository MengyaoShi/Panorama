function main_frame()
im='dream.jpg';
im2='frame.jpg';
[t1,t2]=selectPoints(im,im2)
inputIm=imread(im);
refIm=imread(im2);
[warpIm, mergeIm]=FrameWarp(inputIm,refIm,t2);