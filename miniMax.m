function [bestScore, bestMove] = miniMax(board, playerToken) %falls mit depth -> minimaxNR
    
    bestMove = 0;
    [isOver, finscore] = evaluateBoard(board);
	if ( isOver ) 
		bestScore = finscore;
    else				
        bestScore =  -Inf * playerToken; %also +/- Inf (=schlechtmoeglichster Wert fuer playerToken)       
        
        for i = 1:length(board(:))
            if board(i) == 0 %also Feld noch nicht belegt
                childboard = board;
                childboard(i) = playerToken; %move eintragen
                score = miniMax(childboard, -playerToken); %rekursiver Aufruf
                
                %if current move is better than previous candidates -> update
                if (playerToken == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                    (playerToken == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                    bestScore = score;
                    bestMove = i ;
                end               
            end
        end
    end
end