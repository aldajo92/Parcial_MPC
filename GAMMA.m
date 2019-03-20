function GAMMA = GAMMA(A,B,Hp)
    GAMMA = [];
    for i=1:Hp
        GAMMA = [GAMMA; A^(i-1)*B];
    end
end