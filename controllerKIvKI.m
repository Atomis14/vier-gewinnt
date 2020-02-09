%[bestScore, bestMove] = miniMaxPruning(board, 1, -Inf, Inf, 4)

function finscore = controllerKIvKI(board, playerToken)
    for k = 1:42
        playerToken = playerToken*-1; 

        if playerToken == -1
            [~, column] = miniMaxHeuristic(board, playerToken, 3);
            row = 6 - sum(abs(board(:,column)));
            board(row, column) = playerToken;
        else                    
            [~, column] = miniMaxPruningHeuristic(board, 1, -Inf, Inf, 3);
            row = 6 - sum(abs(board(:,column)));
            board(row, column) = playerToken;
        end

        [isOver, finscore] = evaluateBoard(board); %Unentschieden wird nicht ausgegeben (falls voll)
        if isOver == 1
            %disp("Spieler " + num2str(playerToken) + " hat gewonnen!"); 
            break;
        end
    end
end