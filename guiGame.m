function [newboard, mode] = guiGame(board,playerType,isOver,finscore, row)

    h = findobj('Name','4 Gewinnt');

    board = rot90(board,3); %Display-Koordinaten wie Lesefluss (nicht wie Matrix)
    h.UserData.b = board;   %Wichtige Werte in UserData speichern, damit sie in den Callback-Funktionen zugänglich sind
    h.UserData.p = playerType;
    updateBoard(h); %aktuelles board auf die figure zeichnen, leere Felder clickable machen
    mode = h.UserData.mode;
    
    if h.UserData.mode == "menu"
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

function updateBoard(h)
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
    text(0.5,0, h.UserData.mode, 'FontSize', 14);
    
    %Menü-Knopf
    text(7.5,0, 'Menü', 'FontSize', 14, 'HorizontalAlignment', 'right', 'Color', [1 1 1], 'BackgroundColor', [0 0 0], 'Tag','clickable','ButtonDownFcn',@menu);
    
    %Spieler-Anzeige
    if player == 1
        name = "Rot";
        color = [1 0 0];
    else
        name = "Grün";
        color = [0 0.8 0];
    end
    text(4,0, [name + ' ist dran'], 'FontSize', 20, 'HorizontalAlignment', 'center', 'Color', color)
    
    % Fill in the marks
    for i=1:7
        %Buttons platzieren
        
        if(sum(abs(board(i,:))) < 6)    %Falls Zeile noch frei
            col = sum(abs(board(i,:)))+1;
            linindex = sub2ind(size(board),i,col);
            rectangle('Position',[i-0.45 7 0.9 0.5],'FaceColor',[0.2 0.2 0.2],...
                   'UserData',linindex, 'Tag','clickable','ButtonDownFcn',@clickedCallback);
        else %Falls Zeile voll
            rectangle('Position',[i-0.45 7 0.9 0.5],'FaceColor',[0.9 0.9 0.9]);
        end
       

        %Spielsteine einfüllen
        for j=1:6           
            if board(i,j)==1           
                rectangle('Position',[i-0.5 j-0.5 1 1], 'Curvature', [1 1], 'FaceColor', [1 0 0]);
            elseif board(i,j)==-1
                rectangle('Position',[i-0.5 j-0.5 1 1], 'Curvature', [1 1], 'FaceColor', [0 0.8 0]);
            end
        end
    end
    drawnow 
end

function clickedCallback(obj,evt,h) %vor dem Zeichnen muss schon der move überprüft werden
%Verarbeitet Klicks auf die Rechtecke im TicTacToe-Board
    h = findobj('Name','4 Gewinnt');
    h.UserData.m = obj.UserData; %geklickte Spalte %das ist der lineare Index des geklickten Rechtecks
    h.UserData.b(h.UserData.m)=h.UserData.p; %entsprechenden Wert (1/-1) dort ins board schreiben
    %updateBoard(h); %geht, aber dann wird alles neu gezeichnet -> langsam
    animation(h,h.UserData.m,h.UserData.p); %den neuen Mark anzeigen
    uiresume(h);
end

function finished(finscore)
    h = findobj('Name','4 Gewinnt');
    disp(["finscore: " + finscore]);
    if finscore == 0
        message = "Unentschieden"
        bgcolor = [0.8 0.8 0.8 0.7];
    elseif finscore < 0
        message = "Der Gewinner ist: Grün"
        bgcolor = [0 0.8 0 0.7];
    elseif finscore > 0
        message = "Der Gewinner ist: Rot"
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

function restart(obj,evt,h)
    h = findobj('Name','4 Gewinnt');
    h.UserData.b = zeros(7,6);
    updateBoard(h)
    uiresume
end

function quit(obj,evt,h)
    h = findobj('Name','4 Gewinnt');
    close(h)
end

function menu(obj, evt, h)
    h = findobj('Name','4 Gewinnt');
    h.UserData.mode = 'menu';
    uiresume
end