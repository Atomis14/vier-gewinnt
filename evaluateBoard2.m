function finscore = evaluateBoard2(board)
    finscore = 0;

    %Durch alle leeren Felder durch und pr�fen ob mit 3 anderen 
%     
    for i = 1:size(board(:))    %jedes nicht ausgef�llte Feld
        if board(i) ~= 0
            continue;
        end
        [row, col] = ind2sub(size(board),i);
        
        %Kolonne �berpr�fen
        if (row < 4) && abs(sum(board(row:row+3, col))) == 3
           finscore = finscore + sum(board(row:row+3, col));
           %disp(['Kolonne gefunden an ' num2str(row)])
        end
        
        %Reihe überprüfen
        for clmn = col-3:col %Problem? korrigiert: wenn alle leeren cols durchgegangen werden, kommen durch +/- 3 spalten doppelt
           if (clmn > 0) && (clmn < 5) && abs(sum(board(row, clmn:clmn+3))) == 3
               finscore = finscore + sum(board(row, clmn:clmn+3));
               %disp(['Reihe gefunden an ' num2str(col)])
           end
        end
        
        %Diagonale überprüfen
        for k = -3:0 
            r = row + k; %diagonale L.o.-R.u.
            c = col + k;
            if (r > 0) && (r < 4) && (0 < c) && (c < 5) && abs(trace(board(r:r+3, c:c+3))) == 3
                finscore = finscore + trace(board(r:r+3, c:c+3));
            end
            r = row - k; %diagonale R.o.-L.u.
            c = col + k;
            if (r > 3) && (r < 7) && (0 < c) && (c < 5) && abs(trace(board(r:-1:r-3, c:c+3))) == 3
                finscore = finscore + trace(board(r:-1:r-3, c:c+3));
            end
        end            
    end



    %Reihen ueberpruefen
%     for row = 1:6
%         for col = 1:4
%             if abs(sum(board(row, col:col+3))) == 3
%                 finscore = finscore + sum(board(row, col:col+3));
%             end
%         end
%     end

    %Kolonnen ueberpruefen
%     for col = 1:7
%         for row = 1:3
%             if abs(sum(board(row:row+3,col))) == 3
%                 finscore = finscore + sum(board(row:row+3,col));
%             end
%         end
%     end
% 
%     for i = -3:3 %diagonale geraden
%         diagonalL = diag(board,i);
%         diagonalR = diag(fliplr(board),i);
%         for k = 1:(length(diagonalL)-3)
%             if abs(sum(diagonalL(k:k+3))) == 3
%                 finscore = finscore + sum(diagonalL(k:k+3));
%             end
%             if abs(sum(diagonalR(k:k+3))) == 3
%                 finscore = finscore + sum(diagonalR(k:k+3));
%             end
%         end
%     end
    
end
