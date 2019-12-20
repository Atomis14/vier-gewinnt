%function [isOver, finscore] = evaluateBoard(board)
%Hat jemand gewonnen? Geraden und Diagonalen ueberpruefen und ob Spielfeld
%voll
%board: Spielfeld-Matrize als Uebergabewert, isOver: Spielstand, finscore: minimax-auszahlung/ wer gewonnen hat 


board = zeros(6,7);
board(1:4, 2) = -1


%Reihen ueberpruefen
for row = 1:6
    for col = 1:4
        if abs(sum(board(row, col:col+3))) == 4
            isOver = 1;
            finscore = board(row,col);
            return
        end
    end
end

%Kolonnen ueberpruefen
for col = 1:7
    for row = 1:3
        if abs(sum(board(row:row+3,col))) == 4
            isOver = 1;
            finscore = board(row,col);
            return
        end
    end
end

%TODO Diagonalen ueberpruefen; mit diag arbeiten

for i = -2:2 %diagonale geraden
    diagonal = diag(board,i);
    abs(sum(diagonal(i+2:i+5))) == 4;
end


%end