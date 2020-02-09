function [isOver, finscore] = evaluateBoard(board)
    %Hat jemand gewonnen? Geraden und Diagonalen ueberpruefen und ob Spielfeld voll
    %board: Spielfeld-Matrize als Uebergabewert, isOver: Spielstand, finscore: minimax-auszahlung/ wer gewonnen hat 

    isOver = 0;
    finscore = NaN;

    if sum(abs(board(:))) == 42 %Spielfeld voll?
        isOver = 1;
        finscore = 0;
        return
    end

    for i = 1:size(board(:))    %jedes ausgefuellte Feld
        
        if board(i) == 0
            continue;
        end
        [row, col] = ind2sub(size(board),i);

        %Kolonne ueberpruefen
        if (row < 4) && abs(sum(board(row:row+3, col))) == 4
            isOver = 1;
            finscore = board(row,col)*100;
        end

        %Reihe überprüfen
        for clmn = col-3:col 
           if (clmn > 0) && (clmn < 5) && abs(sum(board(row, clmn:clmn+3))) == 4
               isOver = 1;
               finscore = board(row,col)*100;
           end
        end

        %Diagonale überprüfen
        for k = -3:0 % k = für die Diagonale Verschiebung
            r = row + k; %diagonale L.o.-R.u.
            c = col + k;
            if (r > 0) && (r < 4) && (0 < c) && (c < 5) && abs(trace(board(r:r+3, c:c+3))) == 4
                isOver = 1;
                finscore = board(row,col)*100;
            end
            r = row - k; %diagonale R.o.-L.u.
            c = col + k;
            if (r > 3) && (r < 7) && (0 < c) && (c < 5) && abs(trace(board(r:-1:r-3, c:c+3))) == 4
                isOver = 1;
                finscore = board(row,col)*100;
            end
        end                        
    end
end