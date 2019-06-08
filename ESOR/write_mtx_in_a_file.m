function write_mtx_in_a_file(full_path_of_file, A)
    fid = fopen(full_path_of_file,'wt');
    for i = 1:size(A,1)
        fprintf(fid,'%g ',A(i,:));
        fprintf(fid,'\n');
    end
    fclose(fid);
end