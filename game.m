function game()
    
    while 1   
        [mode, level] = guiMenu();
        startPlayer = [-1,1];
        playerToken = startPlayer(randi([1,2], 1));
        if mode == "2 Spieler"
            pvp(zeros(6,7), playerToken);
        elseif mode == "1 Spieler"
            pvki(zeros(6,7), playerToken, level);
        end
    end
    
end