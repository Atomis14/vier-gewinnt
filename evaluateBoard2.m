function finscore = evaluateBoard2(board)
    finscore = 0;

    %Durch alle leeren Felder durch und prüfen ob mit 3 anderen 
%     
%     for i = 1:size(board(:))    %jedes nicht ausgefüllte Feld
%         if board(i) ~= 0
%             continue;
%         end
%         [row, col] = ind2sub(size(board),i);
%         
%         %Spalte überprüfen
%     end



    %Reihen ueberpruefen
    for row = 1:6
        for col = 1:4
            if sum(board(row, col:col+3)) == 3
                finscore = finscore + 1;
            end
            if sum(board(row, col:col+3)) == -3
                finscore = finscore - 1;
            end
        end
    end

    %Kolonnen ueberpruefen
    for col = 1:7
        for row = 1:3
            if sum(board(row:row+3,col)) == 3
                finscore = finscore + 1;
            end
            if sum(board(row:row+3,col)) == -3
                finscore = finscore - 1;
            end
        end
    end

    for i = -3:3 %diagonale geraden
        diagonalL = diag(board,i);
        diagonalR = diag(fliplr(board),i);
        for k = 1:(length(diagonalL)-3)
            if sum(diagonalL(k:k+3)) == 4
                finscore = finscore + 1;
            end
            if sum(diagonalL(k:k+3)) == -4
                finscore = finscore - 1;
            end
            if sum(diagonalR(k:k+3)) == 4
                finscore = finscore + 1;
            end
            if sum(diagonalR(k:k+3)) == -4
                finscore = finscore - 1;
            end
        end
    end
    
end
