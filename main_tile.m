function main_tile()
%Order of select t1 must be left top, left bottom, then right top, right
%bottom. Order of select t2 can be random and anywhere in picture, because
%we only care about firt input jpg.
[t1,t2]=selectPoints('victorian.jpg','black.jpg');
inputIm=imread('victorian.jpg');
Ired=rectify(inputIm,t1);

