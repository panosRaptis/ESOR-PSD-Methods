function [A, flag] = create_a_standard_matrix(k,l,d,r,s,n) % create the pentadiagonal matrix with parametres k,l,d,r,s,n
A = diag(d*ones(n,1));
up_1_diag = diag(r*ones(n-1,1),1);
up_2_diag = diag(s*ones(n-2,1),2);
down_1_diag = diag(l*ones(n-1,1),-1);
down_2_diag = diag(k*ones(n-2,1),-2);

A = A + up_1_diag + up_2_diag + down_1_diag + down_2_diag;

flag = 0;
for i = 1:n
    if sum(abs(A(i,:))) > abs(2*A(i,i))
        flag = 1;
    end
end
end