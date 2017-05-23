function [t1,t2]=selectPoints(im,im2)
[selectedMovingPoints, selectedFixedPoints]=cpselect(im,im2, 'Wait', true);
t1=selectedMovingPoints';
t2=selectedFixedPoints';

    
%t1=movingPoints',t2=fixedPoints'