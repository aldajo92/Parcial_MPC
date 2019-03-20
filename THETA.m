function THETA = THETA(A,B,Hp)

    THETA = [];
    Gamma = GAMMA(A,B,Hp);
    
    for i=1:Hp
        temp_Gamma = Gamma(1:(Hp-i+1)*size(B,1),1:size(B,2));
        temp = [zeros(size(Gamma,1)-size(temp_Gamma,1), size(Gamma,2)); temp_Gamma];
        THETA = [THETA temp];
    end

end