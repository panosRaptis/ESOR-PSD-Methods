function [A] = create_random_matrix(n) % create a random pentadiagonal (strict diagonially dominant)
A = zeros(n,n);
choice_diag = setdiff(-10:10, -4:4);
diagonial = diag(choice_diag(randi(length(choice_diag)))*ones(n,1));


r = -1 + 2*round(rand(),2); up_1_diag = diag(r*ones(n-1,1),1);
r = -1 + 2*round(rand(),2); up_2_diag = diag(r*ones(n-2,1),2);
r = -1 + 2*round(rand(),2); down_1_diag = diag(r*ones(n-1,1),-1);
r = -1 + 2*round(rand(),2); down_2_diag = diag(r*ones(n-2,1),-2);

A = diagonial + up_1_diag + up_2_diag + down_1_diag + down_2_diag;
end