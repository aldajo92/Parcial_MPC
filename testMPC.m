clc; clear; close all;

Ts = 0.1;
Tf = 200;

Hp = 5;

% Systema continuo
A = [0 1;0 0];
B = [0; 1];
C = [1 0];
D = [0];

P_0 = 10;
Q_0 = P_0;
R_0 = 1;

R = R_0*eye(size(B,2));
Q = Q_0*eye(size(C,1));
P = P_0*eye(size(C,1));

% ========== Initial Values ========= %
x_0 = [1;-1];
x_sys = x_0;
u_sys_0 = [0];
u_sys = u_sys_0;
% YY_sys = zeros(Samples,size(C,1));
% UU_sys = zeros(Samples,size(B,2));

[QE, RE] = PQR_expand(P,Q,R,Hp);

Gamma = GAMMA(A,B,Hp);
Psi = PSI(A,Hp);
Theta = THETA(A,B,Hp);
REF = ref_expand(7,Hp);
CE = C_expand(C,Hp);

f_mpc = 2*([CE*Psi*x_0]'*QE*[CE*Theta]-REF'*QE*CE*Theta);
H_mpc = (Theta'*CE'*QE*CE*Theta + RE)

u_init = u_sys_0;

u_min = [0];
u_max = [0.8];

y_min = [-0.035];
y_max = [10000000];

del_u_min = [-10000];
del_u_max = [10000];

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

U_total = quadprog(2*H_mpc, f_mpc, A_restriction, f1_restriction)