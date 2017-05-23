function Ired=rectify(inputIm,t1)
%Order of points selection must be left top, left bottom, righ top, right
%bottom.
[Rows1, Cols1, three]=size(inputIm);
t1_Cols=t1(:,1);
t1_Rows=t1(:,2);
N=50;%Cols,x
M=100;%Rows,y
t2=[0,0,N, N;0, M,0, M];
P = computeH(t1, t2);
corners=[[0;0;1],[Cols1;0;1],[0; Rows1; 1],[Cols1; Rows1; 1]];
corners_trans=P*corners;
third = [corners_trans(3,:);corners_trans(3,:);corners_trans(3,:)];
corners_trans=corners_trans./third;
% Find Min and Max col row in refIm.
Min_row=min(corners_trans(2,:));
Min_col=min(corners_trans(1,:));
Max_row=max(corners_trans(2,:));
Max_col=max(corners_trans(1,:));

%Find corresponding edge
for i=1:4
    if any(corners_trans(:,i)==Min_row)
        Original_minRow=inv(P)*(corners_trans(:,i)+[0,0-Min_row,0]');
        Original_minRow=Original_minRow/Original_minRow(3,1);
    end
    
    if any(corners_trans(:,i)==Min_col)
        Original_minCol=inv(P)*(corners_trans(:,i)+[0-Min_col,0,0]');
        Original_minCol=Original_minCol/Original_minCol(3,1);
    end
end


I1=inputIm;
for i=1:M%row, y.
    for j=1:N%column, x.
        v1 = [j;i;1]; %x,y, 1. column, row. Image2
        v2 = inv(P)*v1;
        v3 =v2/v2(3,1); %image 1.
        if (floor(v3(1,1)) <=0 || floor(v3(2,1))<=0 || floor(v3(1,1))+1>Cols1  || floor(v3(2, 1))+1> Rows1)
            continue;
        else
            a=v3(1,1)-floor(v3(1,1));
            b=v3(2,1)-floor(v3(2,1));   
            
            Ired(i,j,:)=(1-a)*(1-b)*I1(floor(v3(2,1)),floor(v3(1,1)),:)+a*(1-b)*I1(floor(v3(2,1))+1, floor(v3(1,1)),:)+a*b*I1(floor(v3(2,1)+1), floor(v3(1,1)+1),:)+(1-a)*b*I1(floor(v3(2,1)),floor(v3(1,1))+1,:);
            
        end
    end
end

image(Ired);
end