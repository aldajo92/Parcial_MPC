function [Q_exp, R_exp] = PQR_expand(P,Q,R,Hp)
    I_R = eye(Hp);
    R_exp = kron(I_R,R);
    
    I_Q = eye(Hp-1);
    Q_exp = kron(I_Q,Q);
    Q_exp = [
        Q_exp zeros(size(Q_exp,1),size(Q,2));
        zeros(size(Q,1),size(Q_exp,2)) P
        ];

end