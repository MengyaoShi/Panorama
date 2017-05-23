function verify(t1, t2,h, st1, st2)
im1=imread(st1); 
im2=imread(st2);
[m,n,three]=size(im2);
[two, N]=size(t1);
t1_ext=[t1;ones(1,N)];
t2_ext=[t2;ones(1,N)];
t2_cal=[];

for i=1:N
    v1=t1_ext(:,i);
    v2=h*v1;
    v3=v2/v2(3,1);
    position2=[v3(1);v3(2)];
    if position2(1)>n || position2(1)<0 || position2(2)>m || position2(2)<0
        continue
    else
        t2_cal=[t2_cal,position2];
    end
end

subplot(1,2,1)
image(im1);
hold on
plot(t1(1,:),t1(2,:),'b.', 'MarkerSize',20)
title('Original plot before transformation')
subplot(1,2,2)
image(im2);
hold on
plot(t2_cal(1,:),t2(2,:),'r.','MarkerSize',20)   
title('Calculated points after transformation')

