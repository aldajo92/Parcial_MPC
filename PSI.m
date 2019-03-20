function PSI = PSI(A,Hp)
    PSI = [];
    for i = 1:Hp
       PSI = [PSI ; A^i];
    end
end