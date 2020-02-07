function [correct, problems] = testMiniMax(testCase)
%correct: Anz. richtig geloester testCases, problems: Anz. Probleme, testCase:
%verschiedene Tests, expR = expectedResult

% CommandWindow -> i ha kei Ahnig woher da "ans" chont wo usgeh werd

correct = 0;
problems = 0;

if testCase == 0 % 0 = um alle Cases zu testen
    for testCase = 1:6 % <- manuel an Case-Anzahl(unten) anpassen nicht vergessen !!!
        [board, expR] = testBoardMiniMax(testCase); %Board und erwartetes Resultat werden geholt
        [~, column] = miniMax(board, -1, 2);
        if column == expR 
            correct = correct + 1;
            %disp('correct')    
        else
            problems = problems + 1;
            disp(['Problem at testCase: ' num2str(testCase)])
        end
    end
    disp(['Correct: ' num2str(correct) ' Problems: ' num2str(problems)])
else %falls nur ein Einzellfall getestet wird
    [board, expR] = testBoardMiniMax(testCase);
    [~, column] = miniMax(board, -1, 2);
    if column == expR
        disp('correct')    
    else
        disp(['Problem at testCase: ' num2str(testCase)])
    end
end

end

%----------------------------------------------------------------------------------------------------------

function [board, expR] = testBoardMiniMax(testCase)
% testBoardMiniMaxs werden hier geschrieben, gibt ein board und das erwartete
% Resultat zurück; bei der for-Schleife "End-Zahl" der Anz. Cases anpassen


board = zeros(6,7); %erstellt board
switch testCase %beliebig viele Tests schreiben, board und expR angeben! und cases dürfen keine luecken haben (3_5 6..)
    case 1 %waagrecht
        board(6, 1:3) = -1;
        expR = 4;
               
    case 2
        board(6, 5:7) = 1;
        expR = 4;
        
    case 3 %senkrecht PROBLEM-> Zug wird als gleichwertig empfunden und zufällig gewählt -> was war die Lösung...?
        board(4:6, 5) = -1;
        expR = 5; 
        
    case 4
        board(4:6, 3) = 1;
        expR = 3;
        
    case 5 %diagonal
        board = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 -1  -1 0 0 0; 0 -1 -1 1 0 0 0; -1 1 1 1 0 0 0];
        expR = 4;
        
    case 6
        board = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 -1 1 0 0; 0 0 0 -1 -1 1 0; 0 0 0 -1 -1 1 1];
        expR = 4;
        
                        
end

end
