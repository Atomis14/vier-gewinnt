function finscore = evaluateBoard2(board)
    finscore = 0;

    %Durch alle leeren Felder durch und pr�fen ob mit 3 anderen 
%     
%     for i = 1:size(board(:))    %jedes nicht ausgef�llte Feld
%         if board(i) ~= 0
%             continue;
%         end
%         [row, col] = ind2sub(size(board),i);
%         
%         %Spalte �berpr�fen
%     end



    %Reihen ueberpruefen
    for row = 1:6
        for col = 1:4
            if abs(sum(board(row, col:col+3))) == 3
                finscore = finscore + sum(board(row, col:col+3));
            end
        end
    end

    %Kolonnen ueberpruefen
    for col = 1:7
        for row = 1:3
            if abs(sum(board(row:row+3,col))) == 3
                finscore = finscore + sum(board(row:row+3,col));
            end
        end
    end

    for i = -3:3 %diagonale geraden
        diagonalL = diag(board,i);
        diagonalR = diag(fliplr(board),i);
        for k = 1:(length(diagonalL)-3)
            if abs(sum(diagonalL(k:k+3))) == 3
                finscore = finscore + sum(diagonalL(k:k+3));
            end
            if abs(sum(diagonalR(k:k+3))) == 3
                finscore = finscore + sum(diagonalR(k:k+3));
            end
        end
    end
    
end
