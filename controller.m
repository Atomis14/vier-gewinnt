board = zeros(6,7);
playerToken = -1;

i = 0;
while i <= 42
    if isnan(board) %falls Spiel beendet wurde
        break;
    end
    playerToken = playerToken*-1;  
    i = i+1
    [isOver, finscore] = evaluateBoard(board);
    if isOver == 1
        disp("Spieler " + num2str(playerToken) + " hat gewonnen!");
        i = 1
        board = guiPvP(board, playerToken, isOver, finscore); %damit letztes Token angezeigt wird
        continue;
    end
    board = guiPvP(board, playerToken, isOver);
    
end