function [correct, problems] = testHeuristic(testCase)
%correct: Anz. richtig geloester testCases, problems: Anz. Probleme, testCase:
%verschiedene Tests, expR = expectedResult

correct = 0;
problems = 0;

if testCase == 0 % 0 = um alle Cases zu testen
    for testCase = 1:8 
        [board, expR] = testBoard(testCase); %Board und erwartetes Resultat werden geholt
        if evaluateBoard2(board) == expR 
            correct = correct + 1;
            %disp('correct')    
        else
            problems = problems + 1;
            finscore = evaluateBoard2(board)
            disp(['Problem at testCase: ' num2str(testCase)])
        end
    end
    disp(['Correct: ' num2str(correct) ' Problems: ' num2str(problems)])
else %falls nur ein Einzellfall getestet wird
    [board, expR] = testBoard(testCase);
    if evaluateBoard2(board) == expR
        disp('correct')    
    else
        disp(['Problem at testCase: ' num2str(testCase)])
        finscore = evaluateBoard2(board)
    end
end

end

%----------------------------------------------------------------------------------------------------------

function [board, expR] = testBoard(testCase)
% TestBoards werden hier geschrieben, gibt ein board und das erwartete
% Resultat zurück;


board = zeros(6,7);
switch testCase 
    case 1
        board(4:6, 2) = -1;
        expR = -3;
               
    case 2
        board(4:6, 5) = 1;
        expR = 3;
        
    case 3
        board(4:6, 4) = 1;
        board(3, 1:3) = 1;
        expR = 6;
        
    case 4
        board = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 -1 1 0 0 0; 0 -1 -1 1 0 0 0; -1 1 1 1 0 0 0];
        expR = 3; 
        
    case 5
        board = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 -1 1 0 0; 0 0 0 -1 -1 1 0; 0 0 0 1 -1 -1 1];
        expR = 0; % beide gleich gut == 0
        
    case 6
        board = [0 0 0 0 0 0 0; 0 0 0 0 0 0 0; 0 0 0 -1 0 0 0; 0 0 -1  -1 0 0 0; 0 1 -1 1 0 0 0; -1 1 1 1 0 0 0];
        expR = 3;
        
    case 7
        board(6, 3:5) = -1;
        expR = -6; 
        
    case 8
        board(4, 3:5) = 1;
        board(4:6, 3) = 1;
        expR = 9; 
                        
end

end
