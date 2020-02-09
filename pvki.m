function pvki(board, playerToken, level)
    i = 0;
    while i <= 42
        playerToken = playerToken*-1;
        i = i+1;
        [isOver, finscore] = evaluateBoard(board);
        if isOver == 1
            i = 0;
            board = guiGame(board, playerToken, isOver, finscore); %damit letztes Token angezeigt wird
            playerToken = playerToken*-1;
            continue
        else
            if playerToken == 1     %Spieler am Zug
                [board, mode] = guiGame(board, playerToken, isOver);
            else                    %Ki am Zug
                if level == 1
                    [~, column] = miniMaxHeuristic(board, playerToken, 4);
                elseif level == 2
                    [~, column] = miniMaxPruningHeuristic(board, playerToken, -Inf, Inf, 5);
                elseif level == 3
                    [~, column] = miniMaxPruningHeuristic(board, playerToken, -Inf, Inf, 7);
                end
                row = 6 - sum(abs(board(:,column)));
                [~, mode] = guiGame(board, playerToken, isOver, finscore, [7-row, column]);
                board(row, column) = playerToken;
            end
        end
        if mode == "menu"
            return
        end
    end
end