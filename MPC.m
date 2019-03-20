function [U_total,H_mpc,f_mpc] = MPC(QE,RE,Psi,Theta,CE,REF,x_0,u_init,Hp,u_min,u_max,y_min,y_max)

    f_mpc = 2*([CE*Psi*x_0]'*QE*[CE*Theta]-REF'*QE*CE*Theta);
    H_mpc = (Theta'*CE'*QE*CE*Theta + RE);
    
    A_u_min = -eye(size(u_init,1)*Hp);
    A_u_max = eye(size(u_init,1)*Hp);

    f1_u_kron = ones(Hp,1);
    f1_u_min = kron(f1_u_kron, -(u_min));
    f1_u_max = kron(f1_u_kron, (u_max));

    A_x_min = -CE*Theta;
    A_x_max = CE*Theta;

    f1_x_kron = ones(Hp,1);
    f1_x_min = - (kron(f1_x_kron, y_min) - CE*Psi*x_0);
    f1_x_max = kron(f1_x_kron, y_max) - CE*Psi*x_0;

    % A_del_u_min = -eye(size(u_init,1)*Hp);
    % A_del_u_max = eye(size(u_init,1)*Hp);
    % 
    % f1_del_u_min = kron(f1_u_kron, -del_u_min);
    % f1_del_u_max = kron(f1_u_kron, del_u_max);

    A_restriction = [A_u_min; A_u_max; A_x_min; A_x_max];
    f1_restriction = [f1_u_min; f1_u_max; f1_x_min; f1_x_max];

    U_total = quadprog(2*H_mpc, f_mpc, A_restriction, f1_restriction);

end