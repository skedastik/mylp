function [z0, A, b, c, b_vars, nb_vars] = mylp_load(fpath)
    fid = fopen(fpath, "r");
    
    m       = fscanf(fid, '%d', [1,1]);
    n       = fscanf(fid, '%d', [1,1]);
    b_vars  = fscanf(fid, '%d', [m,1]);
    nb_vars = fscanf(fid, '%d', [n,1]);
    b       = fscanf(fid, '%f', [m,1]);
    A       = fscanf(fid, '%f', [n,m])';
    z0      = fscanf(fid, '%f', [1,1]);
    c       = fscanf(fid, '%f', [n,1]);
    
    fclose(fid);
end
