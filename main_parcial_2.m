clc; clear; close all;

Ts = 0.1;
Tf = 200;

Hp = 20;

% Systema continuo
A = [0 1;0 0];
B = [0; 1];
C = [1 0];
D = [0];

ssC = ss(A,B,C,D);
ssD = c2d(ssC, Ts);

%%

time = 0:Ts:Tf;
Samples = size(time, 2);

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
YY_sys = zeros(Samples,size(C,1));
UU_sys = zeros(Samples,size(B,2));

% ============ Ref signal ============== %
mpc_RefSignal = ones(Samples, 1);
% mpc_RefSignal(10/Ts:Samples) = 0;

% =========== Restrictions ============= %
u_min = [0];
u_max = [0.8];

y_min = [-0.035];
y_max = [100];

% ========== Calculating previous values ==== %
[QE, RE] = PQR_expand(P,Q,R,Hp)

Psi = PSI(ssD.A,Hp)
Theta = THETA(ssD.A,ssD.B,Hp)
CE = C_expand(ssD.C,Hp)

for k = 1:Samples
     
     % Save System
     YY_sys(k,:) = (ssD.C*x_sys)';
     
     REF = ref_expand(mpc_RefSignal(k),Hp);
     all_U = MPC(QE,RE,Psi,Theta,CE,REF,x_sys,u_sys,Hp,u_min,u_max,y_min,y_max);
%      MPC(A,B,C,x_0,u_init,Hp,ref,P,Q,R,u_min,u_max,y_min,y_max)
%      [all_U] = MPC(ssD.A,ssD.B,ssD.C,x_sys,u_sys,mpc_RefSignal(k),Hp,P,Q,R,   u_min,u_max,y_min,y_max)
     u_sys = all_U(1);
     UU_sys(k) = u_sys;
     x_sys = ssD.A*x_sys + ssD.B*u_sys;
     
     % =============================================== &
end

subplot(2,1,1);
stairs(time,YY_sys,'LineWidth', 3.0)
hold on
plot(time,mpc_RefSignal,'k--','LineWidth', 3.0);
title('y_{system}');

subplot(2,1,2)
stairs(time,UU_sys);
title('u');
