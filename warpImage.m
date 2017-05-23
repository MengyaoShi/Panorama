function [warpIm, mergeIm]=warpImage(inputIm,refIm,P)
%In inputIm frame, find min and max row colum
[Rows1, Cols1, three]=size(inputIm);
[Rows2, Cols2, three]=size(refIm);
corners=[[0;0;1],[Cols1;0;1],[0; Rows1; 1],[Cols1; Rows1; 1]];
corners_trans=P*corners;
third = [corners_trans(3,:);corners_trans(3,:);corners_trans(3,:)];
corners_trans=corners_trans./third;
% Find Min and Max col row in refIm.
Min_row=min(corners_trans(2,:));
Min_col=min(corners_trans(1,:));
Max_row=max(corners_trans(2,:));
Max_col=max(corners_trans(1,:));


I1=inputIm;

i_offset = 0;
j_offset = 0;
if Min_row<=0
    i_offset=floor(Min_row)-1;
end
if Min_col<=0
    j_offset=floor(Min_col)-1;
end
%Inverse warping    
for i=floor(Min_row):(floor(Max_row)+1)%row, y.
    for j=floor(Min_col):(floor(Max_col)+1)%column, x.
        v1 = [j;i;1]; %x,y, 1. column, row. refIm
        v2 = inv(P)*v1;
        v3 =v2/v2(3,1); %inputIm.
        % If refIm's corresponding pixel in inputIm frame does not exist,
        % continue
        if (floor(v3(1,1)) <=0 || floor(v3(2,1))<=0 || floor(v3(1,1))+1>Cols1  || floor(v3(2, 1))+1> Rows1)
            continue;
        else
            %Use Bilinear interpolation in Lee's slides.
            a=v3(1,1)-floor(v3(1,1));
            b=v3(2,1)-floor(v3(2,1));   
            warpIm(i-i_offset,j-j_offset,:)=(1-a)*(1-b)*I1(floor(v3(2,1)),floor(v3(1,1)),:)+a*(1-b)*I1(floor(v3(2,1))+1, floor(v3(1,1)),:)+a*b*I1(floor(v3(2,1)+1), floor(v3(1,1)+1),:)+(1-a)*b*I1(floor(v3(2,1)),floor(v3(1,1))+1,:);

        end
    end
end
%Move refIm in x y directions if any of Min_row, Min_col is smaller than
%zero. By doing this I can fit both original image and transformed image in
%the same picture.
for i=1:Rows2
    for j=1:Cols2
        refTrans(i-i_offset,j-j_offset,:)=refIm(i,j,:);
    end
end
 %Get new sizes of refTrans, and warpIm.
[rtRows, rtCols, three]=size(refTrans);
[wiRows,wiCols, three]=size(warpIm);

%Stich two pictures together
if wiRows> rtRows && wiCols> rtCols
    mergeIm(1:(rtRows-1), 1:(rtCols-1),:)=max(warpIm(1:(rtRows-1), 1:(rtCols-1),:),refTrans(1:(rtRows-1), 1:(rtCols-1),:));
    mergeIm(rtRows:wiRows, rtCols:wiCols,:)=warpIm(rtRows:wiRows, rtCols:wiCols,:);
    mergeIm(rtRows:wiRows, 1:(rtCols-1),:)=warpIm(rtRows:wiRows, 1:(rtCols-1),:);
    mergeIm(1:(rtRows-1), rtCols:wiCols,:)=warpIm(1:(rtRows-1), rtCols:wiCols,:);
    
elseif wiRows<= rtRows && wiCols> rtCols
    mergeIm(1:(wiRows-1), 1:(rtCols-1),:)=max(warpIm(1:(wiRows-1), 1:(rtCols-1),:),refTrans(1:(wiRows-1), 1:(rtCols-1),:));
    mergeIm(wiRows:rtRows, 1:(rtCols-1),:)=refTrans(wiRows:rtRows, 1:(rtCols-1),:);
    mergeIm(1:wiRows, rtCols:wiCols,:)=warpIm(1:wiRows, rtCols:wiCols,:);
elseif wiRows> rtRows && wiCols <=rtCols
    mergeIm(1:(rtRows-1), 1:(wiCols-1),:)=max(warpIm(1:(rtRows-1), 1:(wiCols-1),:),refTrans(1:(rtRows-1), 1:(wiCols-1),:));
    mergeIm(rtRows:wiRows, 1:(wiCols-1),:)=warpIm(rtRows:wiRows, 1:(wiCols-1),:);
    mergeIm(1:rtRows, wiCols:rtCols,:)=refTrans(1:rtRows, wiCols:rtCols,:);
else
    mergeIm(1:(wiRows-1), 1:(wiCols-1),:)=max(warpIm(1:(wiRows-1), 1:(wiCols-1),:),refTrans(1:(wiRows-1), 1:(wiCols-1),:));
    mergeIm(wiRows:rtRows, wiCols:rtCols,:)=refTrans(wiRows:rtRows, wiCols:rtCols,:);
    mergeIm(wiRows:rtRows, 1:(wiCols-1),:)=refTrans(wiRows:rtRows, 1:(wiCols-1),:);
    mergeIm(1:(wiRows-1), wiCols:rtCols,:)=refTrans(1:(wiRows-1), wiCols:rtCols,:);

end
image(mergeIm);