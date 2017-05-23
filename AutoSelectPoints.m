function [t1,t2]=AutoSelectPoints(str1, str2)
I=imread(str1);
J=imread(str2);
I = single(rgb2gray(I)) ;
J = single(rgb2gray(J)) ;
[fa, da] = vl_sift (I);
[fb, db] = vl_sift (J);

[matches, score] = vl_ubcmatch (da, db, 5.0);

subplot (1,2,1);
imshow (uint8(I));
hold on;
plot (fa(1,matches(1,:)), fa(2, matches(1,:)), 'b*');

subplot (1,2,2);
imshow (uint8 (J));
hold on;
plot (fb(1, matches(2,:)), fb(2, matches (2,:)), 'r*');
t1=[fa(1,matches(1,:)); fa(2, matches(1,:))];
t2=[fb(1, matches(2,:)); fb(2, matches (2,:))];