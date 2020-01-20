board = zeros(6,7);
startPlayer = [-1,1];
playerToken = startPlayer(randi([1,2], 1));

for k = 1:42
    playerToken = playerToken*-1; 
    
    
    if playerToken == -1    %KI
        [~, column] = miniMax(board, playerToken, 5); %depth = Spielstärke
        row = 6 - sum(abs(board(:,column)));
        board(row, column) = playerToken
    else                    %KIschwaecher
        [~, column] = miniMax(board, playerToken, 2); %depth = Spielstärke
        row = 6 - sum(abs(board(:,column)));
        board(row, column) = playerToken
    end
    
    [isOver, finscore] = evaluateBoard(board); %Unentschieden wird nicht ausgegeben (falls voll)
    if isOver == 1
        disp("Spieler " + num2str(playerToken) + " hat gewonnen!"); 
        break;
    end
end