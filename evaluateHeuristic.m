function finscore = evaluateHeuristic(board)
    finscore = 0;

    %Durch alle leeren Felder durch und pr�fen ob sich mit 3 anderen 4er-Reihe ergibt
     
    for i = 1:size(board(:))    %jedes nicht ausgef�llte Feld
        if board(i) ~= 0
            continue;
        end
        [row, col] = ind2sub(size(board),i); % Reihe und Kolonne von Index holen
        
        %Kolonne �berpr�fen
        if (row < 4) && abs(sum(board(row:row+3, col))) == 3
           finscore = finscore + sum(board(row:row+3, col)); % finscore +/- 3
        end
        
        %Reihe überprüfen
        for clmn = col-3:col 
           if (clmn > 0) && (clmn < 5) && abs(sum(board(row, clmn:clmn+3))) == 3
               finscore = finscore + sum(board(row, clmn:clmn+3));
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
end
