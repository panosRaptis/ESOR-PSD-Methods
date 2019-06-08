clc; clear; format long; %double float
tol = 0.5*(10^(-6)); % tolerance
max_interations = 100; flag = 0;
A = []; 
n = -1;

fprintf('> There are the following opportunities:\n');
fprintf('\t1) Create a Pentadiagonal matrix with parameters k, l, d, r, s (Code: 1)\n');
fprintf('\t2) Specific Applications (Code: 2)\n');
fprintf('\t3) Take a matrix from a file (Code: 3)\n');
fprintf('\t4) Create a random strict diagonally dominant matrix (Code: 4)\n');
fprintf('\t5) Exit (Code: 5)\n');
code = input('\n> Give the preferable Code: ');
while(1)
    if code == 1
        k = input('Give k = '); l = input('Give l = '); d = input('Give d = ');
        r = input('Give r = '); s = input('Give s = '); n = input('Give n (dimention of matrix >= 5) = ');
        [A, flag1] = create_a_standard_matrix(k,l,d,r,s,n); % create the pentadiagonal matrix with parametres k,l,d,r,s,n (matrix's dimension)
        if flag1 == 1
            p = input('The pentadiagonal matrix isnt strict diagonially dominant. Do you want to continue? Y or N? ','s');
            if p == 'N' || p == 'n'
                code = input('\n> Give the preferable Code: ');
                continue;
            end
        end
        saving_ans = input('Do you want to save this matrix in a txt file? Y or N?: ', 's');
        if saving_ans == 'Y' || saving_ans  == 'y'
           file_full_path = input('Give the full path of file: ', 's'); % read the full path of the txt file to be read the preferable matrix
           % for example: C:\users\panos\Desktop\panos_matrix.txt
           write_mtx_in_a_file(file_full_path, A); % write the matrix into the txt file
        end    
    elseif code == 2
        fprintf('\t1)Pentadiagonal Matrix with k = -0.1, l = -0.2, d = 4, r = -0.3, s = -0.4\n');
        fprintf('\t2)Pentadiagonal Matrix with k = -0.4, l = -0.3, d = 4, r = -0.2, s = -0.1\n');
        fprintf('\t3)Pentadiagonal Matrix with k = -1.2, l = -0.9, d = 4, r = -0.6, s = -0.3\n');
        app = input('Give the number of preferable application (1-3): ');
        n = input('Give n (demension of matrix >= 5): ');        
        flag1 = -1;
        if app == 1
            [A, flag1] = create_a_standard_matrix(-0.1,-0.2,4,-0.3,-0.4,n);
        elseif app == 2
            [A, flag1] = create_a_standard_matrix(-0.4,-0.3,4,-0.2,-0.1,n);
        else
            [A, flag1] = create_a_standard_matrix(-1.2,-0.9,4,-0.6,-0.3,n);
        end
        if flag1 == 1
            p = input('The pentadiagonal matrix isnt strict diagonially dominant. Do you want to continue? Y or N? ','s');
            if p == 'N' || p == 'n'
                code = input('\n> Give the preferable Code: ');
                continue;
            end
        end
        saving_ans = input('Do you want to save this matrix in a txt file? Y or N?: ','s');
        if saving_ans == 'Y' || saving_ans  == 'y'
           file_full_path = input('Give the full path of file: ', 's'); % read the full path of the txt file to be read the preferable matrix
           % for example: C:\users\panos\Desktop\panos_matrix.txt
           write_mtx_in_a_file(file_full_path, A);
        end
    elseif code == 3
        file_full_path = input('Give the full path of file: ', 's'); % read the full path of the txt file to be read the preferable matrix
        % for example: C:\users\panos\Desktop\panos_matrix.txt
        A = dlmread(file_full_path); % read that matrix from the txt file
        n = length(A); b = A*ones(n,1);        
    elseif code == 4
        n = input('Give n (dimension of matrix >= 5): ');
        A = create_random_matrix(n);
        saving_ans = input('Do you want to save this matrix in a txt file? Y or N?: ','s');
        if saving_ans == 'Y' || saving_ans  == 'y'
           file_full_path = input('Give the full path of file: ', 's'); % read the full path of the txt file to be read the preferable matrix
           % for example: C:\users\panos\Desktop\panos_matrix.txt
           write_mtx_in_a_file(file_full_path, A);
        end    
    elseif code == 5
        fprintf('> GoodBye!!\n'); return
    else % something went wrong!
        fprintf('\n> Something went wrong, please try again!\n');
        fprintf('> There are the following opportunities:\n');
        fprintf('\t1) Create a Pentadiagonal matrix with parameters k, l, d, r, s (Code: 1)\n');
        fprintf('\t2) Specific Applications (Code: 2)\n');
        fprintf('\t3) Take a matrix from a file (Code: 3)\n');
        fprintf('\t4) Create a random strict diagonally dominant matrix (Code: 4)\n');
        fprintf('\t5) Exit (Code: 5)\n');
        code = input('\n> Give the preferable Code: ');
        continue;
    end

    b = A*ones(n,1); % solution x = (1,1,1,....,1)^T
    temp = zeros(n,1);
    solution_star = zeros(n,1);
    solve_time = 0;
    minimum = +Inf; % min of interations
    t_star = 0; w_star = 0;
    min_list = []; t_star_list = []; w_star_list = []; time_list = [];
    for t = 0.1:0.1:1.9
        for w = 0.1:0.1:1.9
            solution = b;
            itcount = 0;
            tic
            while(itcount < max_interations)
               temp = zeros(n,1);
               for i = 1:n % iterative method using components
                  if i > 2 && i <= n-2
                    temp(i) = (1-t)*solution(i) + w*dot(-A(i,i-2:i-1)/A(i,i), temp(i-2:i-1)') + (t-w)*dot(-A(i,i-2:i-1)/A(i,i),solution(i-2:i-1)') + t*dot(-A(i,i+1:i+2)/A(i,i),solution(i+1:i+2)') + (t*b(i)/A(i,i));
                  elseif i <=2
                    temp(i) = (1-t)*solution(i) + w*dot(-A(i,1:i-1)/A(i,i), temp(1:i-1)') + (t-w)*dot(-A(i,1:i-1)/A(i,i),solution(1:i-1)') + t*dot(-A(i,i+1:i+2)/A(i,i),solution(i+1:i+2)') + (t*b(i)/A(i,i));
                  elseif i == n-1
                    temp(i) = (1-t)*solution(i) + w*dot(-A(i,i-2:i-1)/A(i,i), temp(i-2:i-1)') + (t-w)*dot(-A(i,i-2:i-1)/A(i,i),solution(i-2:i-1)') + t*dot(-A(i,n)/A(i,i),solution(i+1)) + (t*b(i)/A(i,i));
                  else
                    temp(i) = (1-t)*solution(i) + w*dot(-A(i,i-2:i-1)/A(i,i), temp(i-2:i-1)') + (t-w)*dot(-A(i,i-2:i-1)/A(i,i),solution(i-2:i-1)') + (t*b(i)/A(i,i));
                  end
               end
               itcount = itcount + 1;
               if norm(temp-solution, +Inf) < tol % stop or continue interations
                   break
               else
                   solution = temp;
               end
            end
            solve_time = toc;
            if itcount < max_interations && itcount < minimum
                minimum = itcount;
                t_star = t; w_star = w;
                solution_star = temp;
                min_list = []; t_star_list = []; w_star_list = []; time_list = [];
                min_list = [minimum]; t_star_list = [t_star]; w_star_list = [w_star];
                time_list = [solve_time];
                flag = 1;
            elseif itcount == minimum && flag == 1
                min_list = [min_list minimum]; t_star_list = [t_star_list t]; 
                w_star_list = [w_star_list w]; time_list = [time_list solve_time];
            end
        end
    end        
    t_star = unique(t_star_list)
    w_star = unique(w_star_list)
    total_min_interations = minimum
    optimal_solve_time = sum(time_list)/length(time_list)
    solution_star
    code = input('\n> Give the preferable Code: ');
end