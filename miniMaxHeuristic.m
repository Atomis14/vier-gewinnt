function [bestScore, bestMove] = miniMaxHeuristic(board, playerToken, depth)
    bestMove = 0;
    [isOver, finscore] = evaluateBoard(board);
	if isOver == 1 %sauber einbauen
		bestScore = finscore*depth;
    elseif depth == 0 %abbruch minimax falls depth > verfügbare Züge?
        bestScore = evaluateHeuristic(board);
    else				
        bestScore =  -Inf * playerToken; %also +/- Inf (=schlechtmoeglichster Wert fuer playerToken)       
        
        for i = 1:7
            %Abbruchbedingung anpassen
            if sum(abs(board(:,i))) ~= 6 %also Spalte noch nicht voll
                childboard = board;
                row = 6 - sum(abs(board(:,i)));
                childboard(row, i) = playerToken; %move eintragen
                [score, ~] = miniMaxHeuristic(childboard, -playerToken, depth-1); %rekursiver Aufruf
                
                %if current move is better than previous candidates -> update
                if (playerToken == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                    (playerToken == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                    bestScore = score;
                    bestMove = i;
                %FALLS MEHRERE GLEICHGUT -> zufall ob bestScore ersetzt wird oder nicht    
                elseif (playerToken == 1 && score == bestScore) || ...    
                    (playerToken == - 1 && score == bestScore)
                    if rand(1)>0.5 %andere Variante: falls mit Vektor -> bester oder zufälliger aussuchen
                       bestScore = score;
                       bestMove = i; 
                    end
                 end               
            end
        end
        
    end
end