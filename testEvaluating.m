function [correct, problems] = testEvaluating(testCase)
%correct: Anz. richtig geloester testCases, problems: Anz. Probleme, testCase:
%verschiedene Tests, expR = expectedResult, expF = expectedFinscore


correct = 0;
problems = 0;

if testCase == 0 % 0 = um alle Cases zu testen
    for testCase = 1:8 % <- manuel an Case-Anzahl(unten) anpassen
        [board, expR] = testBoard(testCase); %Board und erwartetes Resultat werden geholt
        if evaluateBoard(board) == expR 
            correct = correct + 1;
            %disp('correct')    
        else
            problems = problems + 1;
            disp(['Problem at testCase: ' num2str(testCase)])
        end
    end
    disp(['Correct: ' num2str(correct) ' Problems: ' num2str(problems)])
else %falls nur ein Einzellfall getestet wird
    [board, expR] = testBoard(testCase);
    if  evaluateBoard(board) == expR
        disp('correct')    
    else
        disp(['Problem at testCase: ' num2str(testCase)])
    end
end

end

%----------------------------------------------------------------------------------------------------------

function [board, expR] = testBoard(testCase)
% TestBoards werden hier geschrieben, gibt ein board und das erwartete
% Resultat zurück


board = zeros(6,7); %erstellt board
switch testCase %beliebig viele Tests schreiben und bei Bedarf einzeln ansteuern
    case 1 % Kolonne
        board(3:6, 2) = -1;
        expR = 1; 
               
    case 2
        board(3:6, 5) = 1;
        expR = 1;
        
    case 3
        board(4:6, 1) = 1;
        expR = 0; %Spiel noch nicht vorbei
        
    case 4 %
        board = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 -1 0 0 0; 0 0 -1 1 0 0 0; 0 -1 -1 1 0 0 0; -1 1 1 1 0 0 0];
        expR = 1;
        
    case 5
        board = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 1 0 0 0; 0 0 0 -1 1 0 0; 0 0 0 -1 -1 1 0; 0 0 0 -1 -1 1 1];
        expR = 1;
        
    case 6
        board = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 -1 0 0 0; 0 0 -1  -1 0 0 0; 0 1 -1 1 0 0 0; -1 1 1 1 0 0 0];
        expR = 0;
        
    case 7
        board(2, 2:5) = 1;
        expR = 1;
        
    case 8
        board(4, 3:5) = 1;
        board(4, 2) = -1;
        expR = 0;
                        
end

end
