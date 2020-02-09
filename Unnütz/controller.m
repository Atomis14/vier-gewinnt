function finscore = controller(type, board, playerToken)
    %type: verschiedene Arten des Controllers
    %board: spielbrett (falls board=0 -> leer)
    %playerToken: Spieler (falls playerToken=0: zufällig)
    
    if board == 0
        board = zeros(6,7);
    end
    if playerToken == 0
        startPlayer = [-1,1];
        playerToken = startPlayer(randi([1,2], 1));
    end
    
    if type == "pvp-nogui"          %Spieler gegen Spieler mit GUI
        PvP_noGUI(board, playerToken)
    elseif type == "pvp-gui"        %Spieler gegen Spieler ohne GUI
        PvP_GUI(board, playerToken)
    elseif type == "pvki-nogui"
        PvKI_noGUI(board, playerToken)
    elseif type == "pvki-gui"
        PvKI_GUI(board, playerToken)
    elseif type == "kivki-nogui"
        KIvKI_noGUI(board, playerToken)
    end
end



function PvP_noGUI(board, playerToken)
    for i = 1:42
        playerToken = playerToken*-1;  
        while true   %Solange Benutzereingabe ungueltig
            column = input("[Spieler " + num2str(playerToken) + "] Waehle Spalte (1-7) aus: ");
            try int8(column);
                if column < 1 || column > 7
                    disp("Bitte gueltige Spalte (1-7) angeben!");
                    continue;
                else
                    row = 6 - sum(abs(board(:,column)));
                    if row < 1
                        disp("Die Spalte ist schon voll!");
                        continue;
                    else
                        board(row, column) = playerToken
                        break;
                    end
                end
            catch
                disp("Eingabe ungueltig!");
            end
        end
        [isOver, finscore] = evaluateBoard(board);
        if isOver == 1
            disp("Spieler " + num2str(playerToken) + " hat gewonnen!");
            break;
        end
    end
end
function PvKI_noGUI(board, playerToken)
    for i = 1:42
        playerToken = playerToken*-1; 

        if playerToken == -1    %KI
            [~, column] = miniMaxHeuristic(board, playerToken, 4);
            row = 6 - sum(abs(board(:,column)));
            board(row, column) = playerToken
        else                    %Spieler
            while true   %Solange Benutzereingabe ungueltig
            column = input("[Spieler " + num2str(playerToken) + "] Waehle Spalte (1-7) aus: ");
            try int8(column);
                if column < 1 || column > 7
                    disp("Bitte gueltige Spalte (1-7) angeben!");
                    continue;
                else
                    row = 6 - sum(abs(board(:,column)));
                    if row < 1
                        disp("Die Spalte ist schon voll!");
                        continue;
                    else
                        board(row, column) = playerToken
                        break;
                    end
                end
            catch
                disp("Eingabe ungueltig!");
            end
        end

        end
        [isOver, finscore] = evaluateBoard(board);
        if isOver == 1
            disp("Spieler " + num2str(playerToken) + " hat gewonnen!");
            break;
        end
    end
end
function finscore = KIvKI_noGUI(board, playerToken)
    for k = 1:42
        playerToken = playerToken*-1; 


        if playerToken == -1    %KI
            [~, column] = miniMax(board, playerToken, 2); %depth = SpielstÃ¤rke
            row = 6 - sum(abs(board(:,column)));
            board(row, column) = playerToken
        else                    %KIschwaecher
            [~, column] = miniMax(board, playerToken, 2); %depth = SpielstÃ¤rke
            row = 6 - sum(abs(board(:,column)));
            board(row, column) = playerToken
        end

        [isOver, finscore] = evaluateBoard(board); %Unentschieden wird nicht ausgegeben (falls voll)
        if isOver == 1
            disp("Spieler " + num2str(playerToken) + " hat gewonnen!"); 
            break;
        end
    end
end

%Für Spiel verwendet
function PvP_GUI(board, playerToken)

    i = 0;
    while i <= 42
        if isnan(board) %falls Spiel beendet wurde
            break
        end
        playerToken = playerToken*-1;
        i = i+1;
        [isOver, finscore] = evaluateBoard(board);
        if isOver == 1
            disp("Spieler " + num2str(playerToken) + " hat gewonnen!");
            i = 1;
            board = guiGame(board, playerToken, isOver, finscore); %damit letztes Token angezeigt wird
            continue
        end
        [board, mode] = guiGame(board, playerToken, isOver, finscore);
        if mode == "menu"
            return
        end
    end
    
end

function PvKI_GUI(board, playerToken)
    i = 0;
    while i <= 42
        if isnan(board) %falls Spiel beendet wurde
            break;
        end
        playerToken = playerToken*-1;
        i = i+1;
        [isOver, finscore] = evaluateBoard(board);
        if isOver == 1
            disp("Spieler " + num2str(playerToken) + " hat gewonnen!");
            i = 1;
            board = guiGame(board, playerToken, isOver, finscore); %damit letztes Token angezeigt wird
            playerToken = playerToken*-1;
            continue;
        else
            if playerToken == 1     %Spieler am Zug
                board = guiGame(board, playerToken, isOver);
            else                    %Ki am Zug
                disp("!!!KI AM ZUG!!!")
                [~, column] = miniMaxHeuristic(board, playerToken, 4);
                row = 6 - sum(abs(board(:,column)));
                guiGame(board, playerToken, isOver, finscore, [7-row, column]);
                board(row, column) = playerToken;
            end
        end

    end
end

