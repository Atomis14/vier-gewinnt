function testKIvKI()
    playerToken = 1;
    winsPositive = 0;
    winsNegative = 0;
    drawn = 0;
    
    tic;
    
    for i = 1:50
        playerToken = playerToken*-1;
        winner = controllerKIvKI(zeros(6,7), playerToken);
        if winner > 0
            winsPositive = winsPositive+1;
        elseif winner < 0
            winsNegative = winsNegative+1;
        elseif winner == 0
            drawn = drawn+1;
        end
    end
    
    disp("Unentschieden: " + drawn);
    disp("Siege 1: " + winsPositive);
    disp("Siege -1: " + winsNegative);
    disp("Benötigte Zeit: " + toc);
end