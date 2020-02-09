function [newboard, mode] = guiGame(board, playerType, isOver, finscore, row)

    h = findobj('Name','4 Gewinnt');
    
    board = rot90(board,3); %Display-Koordinaten wie Lesefluss (nicht wie Matrix)
    h.UserData.b = board;   %Wichtige Werte in UserData speichern, damit sie in den Callback-Funktionen zugänglich sind
    h.UserData.p = playerType;
    
    updateBoard(h, isOver); %aktuelles board auf die figure zeichnen, leere Felder clickable machen
    mode = h.UserData.mode; %1 oder 2 Spieler oder Menü
    
    if h.UserData.mode == "menu"    %Funktion beenden falls Menü geklikt
        delete(gca)
        newboard = zeros(6,7);
        mode = "menu";
        return
    end
    
    if isOver == 1
        finished(finscore);
    else
        if (playerType==1 && h.UserData.mode == "1 Spieler") || h.UserData.mode == "2 Spieler"
            uiwait(h);
        else
            animation(h,row,-1);
        end
    end

    newboard = rot90(h.UserData.b); %board mit neuem Eintrag zurückgeben 

end


% Hilfsfunktionen und Callbacks%%%%%%%%%%%%%%%%

function updateBoard(h, isOver)
%Zeichnet das aktuelle Board (gespeichert in UserData) auf die figure

    delete(findobj(gca,'Type','text')); %alte Einträge löschen
    delete(findobj(gca,'Type','rectangle')); %alte Einträge löschen

    %Aussenlinie
    rectangle('Position',[0.5 0.5 7 6],'LineWidth',3,'Clipping','off','FaceColor',[1 1 1]) % outside border
    %vertikale Linie
    rectangle('Position',[1.5 0.5 1 6],'LineWidth',1) % inside border
    rectangle('Position',[3.5 0.5 1 6],'LineWidth',1) % inside border
    rectangle('Position',[5.5 0.5 1 6],'LineWidth',1) % inside border
    %horizontale Linien
    rectangle('Position',[0.5 1.5 7 1],'LineWidth',1) % inside border
    rectangle('Position',[0.5 3.5 7 1],'LineWidth',1) % inside border
    rectangle('Position',[0.5 5.5 7 1],'LineWidth',1) % inside border
    
    board = h.UserData.b;
    player = h.UserData.p;
    
    %Modus-Anzeige
    text(0.5,7.8, "Modus: " + h.UserData.mode, 'FontSize', 16)
    
    %Schwierigkeits-Anzeige falls 1-Spieler-Modus
    if h.UserData.mode == "1 Spieler"
        text(0.5,0, "Stufe: " + num2str(h.UserData.level), 'FontSize', 14)
    end
    
    %Menü-Knopf
    text(7.5,0, 'Menü', 'FontSize', 14, 'HorizontalAlignment', 'right', 'Color', [1 1 1], 'BackgroundColor', [0 0 0], 'Tag','clickable','ButtonDownFcn',@menu)
    
    %Spieler-Anzeige
    if isOver == 1
        message = "Spiel vorbei";
        color = [0 0 0];
    elseif player == 1
        message = "Rot ist dran";
        color = [1 0 0];
    else
        message = "Grün ist dran";
        color = [0 0.8 0];
    end
    text(4,0, message, 'FontSize', 20, 'HorizontalAlignment', 'center', 'Color', color)
    
    for i=1:7   %für jede Spalte
        %Buttons platzieren
        if sum(abs(board(i,:))) == 6 || isOver == 1 || (h.UserData.mode == "1 Spieler" && player == -1)
            text(i,7, '  v  ', 'FontSize', 17, 'HorizontalAlignment', 'center', 'Margin', 6, 'Color', [1 1 1], 'BackgroundColor', [0.8 0.8 0.8])
        else
            col = sum(abs(board(i,:)))+1;
            linindex = sub2ind(size(board),i,col);
            text(i,7, '  v  ', 'FontSize', 17, 'HorizontalAlignment', 'center', 'Margin', 6, 'Color', [1 1 1], 'BackgroundColor', [0 0 0], ...
               'UserData',linindex, 'Tag','clickable','ButtonDownFcn',@clickedCallback)
        end    
        %Spielsteine einfüllen
        for j=1:6           
            if board(i,j)==1           
                rectangle('Position',[i-0.5 j-0.5 1 1], 'Curvature', [1 1], 'FaceColor', [1 0 0])
            elseif board(i,j)==-1
                rectangle('Position',[i-0.5 j-0.5 1 1], 'Curvature', [1 1], 'FaceColor', [0 0.8 0])
            end
        end
    end
    
    drawnow 
end

function clickedCallback(obj,evt) %vor dem Zeichnen muss schon der move überprüft werden
%Verarbeitet Klicks auf die Rechtecke im TicTacToe-Board
    h = findobj('Name','4 Gewinnt');
    h.UserData.m = obj.UserData; %geklickte Spalte %das ist der lineare Index des geklickten Rechtecks
    h.UserData.b(h.UserData.m)=h.UserData.p; %entsprechenden Wert (1/-1) dort ins board schreiben
    animation(h,h.UserData.m,h.UserData.p); %den neuen Mark anzeigen
    uiresume(h);
end

%Feld leeren und anzeigen bei Restart
function restart(obj,evt)
    h = findobj('Name','4 Gewinnt');
    h.UserData.b = zeros(7,6);
    updateBoard(h, 0)
    uiresume
end

%Programm beenden
function quit(obj,evt)
    h = findobj('Name','4 Gewinnt');
    close(h)
end

%Menü anzeigen
function menu(obj, evt)
    h = findobj('Name','4 Gewinnt');
    h.UserData.mode = 'menu';
    uiresume
end

%Anzeige bei Spielende
function finished(finscore)
    h = findobj('Name','4 Gewinnt');
    
    if finscore == 0
        message = "Unentschieden";
        bgcolor = [0.8 0.8 0.8 0.7];
    elseif finscore < 0
        message = "Der Gewinner ist: Grün";
        bgcolor = [0 0.8 0 0.7];
    elseif finscore > 0
        message = "Der Gewinner ist: Rot";
        bgcolor = [1 0 0 0.7];
    end
    rectangle('Position', [0.5 0.5 7 6], 'FaceColor', bgcolor);
    text(4,4.5, message, 'FontSize', 25, 'HorizontalAlignment', 'center');
    
    %Buttons bei Spielende
    text(4,3.2, 'Neu starten', 'FontSize', 18, 'HorizontalAlignment', 'center', 'Color', [1 1 1], 'BackgroundColor', [0.1 0.1 0.1], 'Margin', 8, 'Tag','clickable','ButtonDownFcn',@restart);
    text(4,2, 'Beenden', 'FontSize', 15, 'HorizontalAlignment', 'center', 'Color', [1 1 1], 'BackgroundColor', [0.1 0.1 0.1], 'Margin', 6, 'Tag','clickable','ButtonDownFcn',@quit);
    
    uiwait(h);
    
    drawnow
end

%Animation bei Platzierung des Spielsteins
function animation(h,linIndex,playerType)

    %Farbe setzen
    if playerType == 1
        color = [1 0 0];
    else
        color = [0 0.8 0];
    end
    
    if size(linIndex) == 1  %falls User Stein gesetzt hat
        [i,j]=ind2sub(size(h.UserData.b),linIndex);
    else                    %falls KI den Stein gesetzt hat
        i = linIndex(2);    %Spalte
        j = linIndex(1);    %Zeile
    end
 
    %eigentliche Animation ausführen
    token = rectangle('Position', [i-0.5 6 1 1], 'Curvature', [1 1], 'FaceColor', color);
    for k = 1:10*(6.5-j)
        set(token, 'Position', [i-0.5 6-(0.1*k) 1 1]);
        pause(0.01);
    end

end