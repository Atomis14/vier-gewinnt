board = zeros(6,7);
startPlayer = [-1,1];
playerToken = startPlayer(randi([1,2], 1));

for i = 1:42
    playerToken = playerToken*-1; 
    
    
    if playerToken == -1    %KI
        [~, column] = miniMax(board, playerToken, 5);
        row = 6 - sum(abs(board(:,column)));
        board(row, column) = playerToken
    else                    %Spieler
        while true   %Solange Benutzereingabe ungueltig
        column = input("[Spieler " + num2str(playerToken) + "] Waehle Spalte (1-7) aus: ");
        try int8(column);
            if column < 1 || column > 7
                disp("Bitte gueltige Spalte (1-7) angeben!");
                continue;
            else
                row = 6 - sum(abs(board(:,column)));
                if row < 1
                    disp("Die Spalte ist schon voll!");
                    continue;
                else
                    board(row, column) = playerToken
                    break;
                end
            end
        catch
            disp("Eingabe ungueltig!");
        end
    end
    
    
    
    end
    [isOver, finscore] = evaluateBoard(board);
    if isOver == 1
        disp("Spieler " + num2str(playerToken) + " hat gewonnen!");
        break;
    end
end