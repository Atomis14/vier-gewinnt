board = zeros(6,7);
playerToken = -1;

for i = 1:42
    playerToken = playerToken*-1;  
    while true   %Solange Benutzereingabe ung�ltig
        column = input("[Spieler " + num2str(playerToken) + "] W�hle Spalte (1-7) aus: ");
        if ~isnumeric(column) || isempty(column)
            disp("Eingabe ung�ltig!");
            continue;
        elseif column < 1 || column > 7
            disp("Bitte g�ltige Spalte (1-7) angeben!");
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
    end
    [isOver, finscore] = evaluateBoard(board);
    if isOver == 1
        disp("Spieler " + num2str(playerToken) + " hat gewonnen!");
        break;
    end
end