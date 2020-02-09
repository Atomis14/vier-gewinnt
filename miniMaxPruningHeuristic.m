function [bestScore, bestMove] = miniMaxPruningHeuristic(board, playerToken, alpha, beta, depth) %falls mit depth -> minimaxNR
    
    bestMove = 0;
    [isOver, finscore] = evaluateBoard(board);
	if isOver == 1 %sauber einbauen
		bestScore = finscore*depth;
    elseif depth == 0   %unfertiges Board bewerten durch Heuristik
        bestScore = evaluateHeuristic(board);
    else				
        bestScore =  -Inf * playerToken; %also +/- Inf (=schlechtmoeglichster Wert fuer playerToken)       
        
        %Anzahl mögliche 4er, die auf jedem Feld möglich sind (untere Hälfte *2)
        possibilities = [3 4 5 7 5 4 3;
                         4 6 8 10 8 6 4;
                         5 8 11 13 11 8 5;
                         10 16 22 26 22 16 10;
                         8 12 16 20 16 12 8;
                         6 8 10 14 10 8 6];
        
        ind = 6-sum(abs(board));    %Feld, auf das der Stein fallen würde
        branches = zeros(2,7);
        for j = 1:7 %Possibility-Werte für jede Spalte durchgehen
            if ind(j) == 0
                branches(2,j) = j;
                continue
            end
            branches(1,j) = possibilities(ind(j), j);   %Possibility-Wert, der dieses Feld hat
            branches(2,j) = j;                          %Spalte
        end
        branches = sortrows(branches.',1,'descend').';  %Matrix nach dem Possibility-Wert sortieren
        
        for i = branches(2,:)   %in der zweiten Zeile sind die Spalten, nach possibility-Wert sortiert
            if sum(abs(board(:,i))) ~= 6 %Spalte noch nicht voll
                childboard = board;
                row = 6 - sum(abs(board(:,i)));
                childboard(row, i) = playerToken; %move eintragen
                score = miniMaxPruningHeuristic(childboard, -playerToken, alpha, beta, depth-1); %rekursiver Aufruf
                %if current move is better than previous candidates -> update
                if (playerToken == 1 && score > bestScore) || ...    %maximizing player --> wants positive scores
                    (playerToken == - 1 && score < bestScore)    %minimizing player --> wants negative scores
                    bestScore = score;
                    bestMove = i;
                end
                
                %Alpha-Beta-Pruning
                if playerToken == 1
                    alpha = max(alpha, score);
                elseif playerToken == -1
                    beta = min(beta, score);
                end
                if beta <= alpha
                    return
                end
              
            end
        end
        
    end
end