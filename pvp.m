function pvp(board, playerToken)

    i = 0;
    while i <= 42
        if isnan(board) %falls Spiel beendet wurde
            break
        end
        playerToken = playerToken*-1;
        i = i+1;
        [isOver, finscore] = evaluateBoard(board);
        if isOver == 1
            i = 1;
            board = guiGame(board, playerToken, isOver, finscore); %damit letztes Token angezeigt wird
            playerToken = playerToken*-1;
            continue
        end
        [board, mode] = guiGame(board, playerToken, isOver, finscore);
        if mode == "menu"
            return
        end
    end
    
end