A = [-4 2 1;1 6 2;1 -2 5] % matrice a diagonale strictement dominante
x0 = [1; 1; 1]
b = [1; 0; 0]
A * jacobi(A, b, x0, 10^3)
A * GS(A, b, x0, 10^3)
A * SOR(A, b, x0, 0.5, 10^3)
B = [2 1 0; 1 2 0; 0 0 4]
B * gradient_conjugue(B, b, x0)

taille = 2:5:1000;
jacob = [];
gs = [];
sor = [];
gc = [];
for n = taille
    A = matrice_diag_dominante(n);
    B = randi(9, n);
    B = B + B.';
    x0 = randi(9, n, 1);
    b = randi(9, n, 1);
    [vect_p, val_p] = eig(B);
    while min(min(val_p)) < 0
        B = B + n * eye(n);
        [vect_p, val_p] = eig(B);
    end
    tic;
    jacobi(A, b, x0, 10^3);
    t = toc;
    jacob = [jacob t];
    tic;
    GS(A, b, x0, 10^3);
    t = toc;
    gs = [gs t];
    tic;
    SOR(A, b, x0, 0.5, 10^3);
    t = toc;
    sor = [sor t];
    tic;
    gradient_conjugue(B, b, x0);
    t = toc;
    gc = [gc t];
end

plot(taille, jacob, 'r', taille, gs, 'b', taille, sor, 'g', taille, gc, 'y')
    
    
