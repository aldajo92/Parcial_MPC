function [Uresult, PSI, GAMMA, THETA, H, G, Q_exp, R_exp] = MPC_unrestrict_y(A,B,C,X_0,U_init,ref,Hp,P,Q,R)



%     % ==== Agregar esto ==== %
    I_C = eye(Hp);
    C_exp = kron(I_C,C);

    I_R = eye(Hp);
    R_exp = kron(I_R,R);
%     
%     I_Q = eye(Hp-1);
%     Q_exp = kron(I_Q,Q);
%     Q_exp = [
%         Q_exp zeros(size(Q_exp,1),size(Q,2));
%         zeros(size(Q,1),size(Q_exp,2)) P
%         ];
% 
%     PSI = [];
%     for i = 1:Hp
%        PSI = [PSI ; A^i];
%     end
%     CPSI = C_exp*PSI
% 
% %     GAMMA = [];
% %     SUM_AB = zeros(size(A*B));
% %     for i = 1:Hp
% %         SUM_AB = SUM_AB + (A^(i-1)) * B;
% %         GAMMA = [GAMMA ; SUM_AB];
% %     end
% %     CGAMMA = C_exp*GAMMA
%     
%     S_exp = [];
%     Gamma = [];
% 
%     for i=1:Hp
%         Gamma = [Gamma; A^(i-1)*B];
%     end
% 
%     for i=1:Hp
%         temp_Gamma = Gamma(1:(Hp-i+1)*size(B,1),1:size(B,2));
%         temp = [zeros(size(Gamma,1)-size(temp_Gamma,1), size(Gamma,2)); temp_Gamma];
%         S_exp = [S_exp temp];
%     end
%     CGAMMA = C_exp*Gamma;
%     GAMMA = Gamma;
%     
%     THETA = [];
%     for i=1:Hp
%         temp_Gamma = GAMMA(1:(Hp-i+1)*size(B,1),1:size(B,2));
%         temp = [zeros(size(GAMMA,1)-size(temp_Gamma,1), size(GAMMA,2)); temp_Gamma];
%         THETA = [THETA temp];
%     end
%     CTHETA = C_exp*THETA;
%     
%     % Reference expanding
%     ref_exp = kron(ones(Hp,1),ref);
%     
%     % Calculating E_exp
%     E_exp = ref_exp - CPSI*X_0 - CGAMMA*U_init;
% 
%     % Calculating H
%     H = (CTHETA'*Q_exp*CTHETA + R);
% 
%     % Calculating G
%     G = 2*CTHETA'*Q_exp*E_exp;
% 
%     Uresult = (G\H)'/2;

end