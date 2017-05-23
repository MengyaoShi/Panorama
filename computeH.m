function h = computeH(t1, t2)
%t1=movingPoints',t2=fixedPoints'
[two, N]=size(t1);
t1_ext=[t1;ones(1,N)];
t2_ext=[t2;ones(1,N)];
A=[];
%A is matrix in http://web.cs.ucdavis.edu/~yjlee/teaching/ecs174-spring2017/lee_lecture10_homography.pdf
for i=1:N
    a=t2_ext(:,i);
    line1=[t1_ext(:,i)' zeros(1,3) -t1_ext(:,i)'*a(1)];
    line2=[zeros(1,3) t1_ext(:,i)' -t1_ext(:,i)'*a(2)];
    A=[A;line1;line2];
end

%Get eigenvector correspond to smallest eigenvalue of A'*A
[V,D] = eig(A'*A);
h_=V(:,1);
h_=reshape(h_, [3,3]);
h=h_';

%Verify h is correct by display points before and after transformation on
%im1 and im2. You will need to comment this line out or change last two
%variables.
%verify(t1, t2,h, 'crop1.jpg', 'crop2.jpg')
        
        

end

 