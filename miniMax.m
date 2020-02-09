function [bestScore, bestMove] = miniMax(board, playerToken, depth)
    
    bestMove = 0;
    [isOver, finscore] = evaluateBoard(board);
	if isOver == 1
		bestScore = finscore*depth; %mit Tiefe multiplizieren um schneller zu gewinnen
    elseif depth == 0 
        bestScore = 0;
    else				
        bestScore =  -Inf * playerToken; %also +/- Inf (=schlechtmoeglichster Wert fuer playerToken)       
        
        for i = 1:7
            if sum(abs(board(:,i))) ~= 6 %also Spalte noch nicht voll
                childboard = board;
                row = 6 - sum(abs(board(:,i)));
                childboard(row, i) = playerToken; % Zug eintragen
                [score, ~] = miniMax(childboard, -playerToken, depth-1); %rekursiver Aufruf
                
                %falls der momentane Zug besser ist als der vorherige -> überschreiben
                if (playerToken == 1 && score > bestScore) || ...    %max player --> will positive Scores
                    (playerToken == - 1 && score < bestScore)    %minimizing player --> will negative Scores
                    bestScore = score;
                    bestMove = i;
                %FALLS MEHRERE GLEICHGUT -> zufall ob bestScore ersetzt wird oder nicht    
                elseif (playerToken == 1 && score == bestScore) || ...    
                    (playerToken == - 1 && score == bestScore)
                    if rand(1)>0.5 
                       bestScore = score;
                       bestMove = i; 
                    end
                 end               
            end
        end    
    end
end