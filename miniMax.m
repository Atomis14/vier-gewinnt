function [bestScore, bestMove] = miniMax(board, playerToken, depth) %falls mit depth -> minimaxNR
    
    bestMove = 0;
    [isOver, finscore] = evaluateBoard(board);
	if ( isOver || depth == 0 ) 
		bestScore = finscore;
    else				
        bestScore =  -Inf * playerToken; %also +/- Inf (=schlechtmoeglichster Wert fuer playerToken)       
        
        for i = 1:7
            %Abbruchbedingung anpassen
            if sum(abs(board(:,i))) ~= 6 %also Feld noch nicht belegt
                childboard = board;
                row = 6 - sum(abs(board(:,i)));
                childboard(row, i) = playerToken; %move eintragen
                score = miniMax(childboard, -playerToken, depth-1); %rekursiver Aufruf
                
                %if current move is better than previous candidates -> update
                if (playerToken == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                    (playerToken == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                    bestScore = score;
                    bestMove = i;
                end               
            end
        end
    end
end