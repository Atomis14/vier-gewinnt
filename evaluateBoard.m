function [isOver, finscore] = evaluateBoard(board,depth)
%Hat jemand gewonnen? Geraden und Diagonalen ueberpruefen und ob Spielfeld
%voll
%board: Spielfeld-Matrize als Uebergabewert, isOver: Spielstand, finscore: minimax-auszahlung/ wer gewonnen hat; momentan 1/-1 statt 10/-10 

%spieler je 4 in einer reihe (spieler*? oder ist alles voll(=0)? oder
%maximale tiefe(=0)?

isOver = 0; %falls zu NaN, dann auch bei testEvaluating->expR aendern
finscore = NaN;

<<<<<<< HEAD
if (sum(abs(board(:))) == 42)
    isOver = 1;
    finscore = 0;
    disp ('Brett voll: Unentschieden!') %wird nicht ausgegeben, nun sum(sum()) -> funktioniert?
end

%Reihen ueberpruefen
for row = 1:6
    for col = 1:4
        if abs(sum(board(row, col:col+3))) == 4
            isOver = 1;
            finscore = board(row,col)*100;
            return
        end
    end
end

%Kolonnen ueberpruefen
for col = 1:7
    for row = 1:3
        if abs(sum(board(row:row+3,col))) == 4
            isOver = 1;
            finscore = board(row,col)*100;
            return
        end
    end
end

%TODO Diagonalen ueberpruefen; mit diag arbeiten

for i = -3:3 %diagonale geraden
    diagonalL = diag(board,i);
    diagonalR = diag(fliplr(board),i);
    for k = 1:(length(diagonalL)-3)
        if abs(sum(diagonalL(k:k+3))) == 4
            %disp("Die 4er-Reihe liegt in der LINKEN Diagonale")
            isOver = 1;
            finscore = diagonalL(k)*100;
            break
        elseif abs(sum(diagonalR(k:k+3))) == 4
            %disp("Die 4er-Reihe liegt in der RECHTEN Diagonale")
            isOver = 1;
            finscore = diagonalR(k)*100;
            break
        end
    end
end


%end