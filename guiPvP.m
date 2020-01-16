function newboard = guiPvP(board,playerType,isOver,finscore)
% draws the current state on a figure, optionally waits for a user to put
% his mark (click on the board)
% input:
%   board specifies the current state of the game (3x3, 0=empty; 1=mark pl1(X); -1=mark pl2(O))
%   playerType (1/-1) specifies whose turn it is - for other values the GUI
%   does not accept any user-inputs (clicks)

    h = findobj('Name','viergewinnt'); %existierende figure finden
    if isempty(h)
        h = figure('Name','viergewinnt'); %oder neu erschaffen
        axis off;  % prepare to draw 
        xlim([0.5 7.5]); ylim([0.5 7.5]);    
    end

    board = rot90(board,3); %Display-Koordinaten wie Lesefluss (nicht wie Matrix)
    h.UserData.b = board;   %Wichtige Werte in UserData speichern, damit sie in den Callback-Funktionen zugänglich sind
    h.UserData.p = playerType;
    updateBoard(h); %aktuelles board auf die figure zeichnen, leere Felder clickable machen

    if isOver == 1
        finished(finscore);
    else
        if abs(playerType)==1
            uiwait(h); %auf click warten
        end
    end

    h = findobj('Name','viergewinnt');
    if ~isempty(h)
        newboard = rot90(h.UserData.b); %board mit neuem Eintrag zurückgeben 
    else
        newboard = NaN; %Um Fehlermeldung beim Schliessen zu vermeiden
    end

end


%% Hilfsfunktionen und Callbacks%%%%%%%%%%%%%%%%

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
    
    
    % Fill in the marks
    for i=1:7
        %Buttons platzieren
        
        %lineare Indizes für jede Spalte berechnen
        if(sum(abs(board(i,:))) < 6)
            col = sum(abs(board(i,:)))+1;
            linindex = sub2ind(size(board),i,col);
            rectangle('Position',[i-0.45 7 0.9 0.5],'FaceColor',[0.2 0.2 0.2],...
                   'UserData',linindex, 'Tag','clickable','ButtonDownFcn',@clickedCallback);
        else
            rectangle('Position',[i-0.45 7 0.9 0.5],'FaceColor',[0.9 0.9 0.9]);
        end
       


        for j=1:6           
            if board(i,j)==1           
                rectangle('Position',[i-0.5 j-0.5 1 1], 'Curvature', [1 1], 'FaceColor', [1 0 0]);
                %text(i,j,'X','FontUnits','normalized','FontSize',0.2,'HorizontalAlignment','center');
            elseif board(i,j)==-1
                rectangle('Position',[i-0.5 j-0.5 1 1], 'Curvature', [1 1], 'FaceColor', [0 1 0]);
                %text(i,j,'O','FontUnits','normalized','FontSize',0.2,'HorizontalAlignment','center');
            end
        end
    end
    drawnow 
end

function clickedCallback(obj,evt,h) %vor dem Zeichnen muss schon der move überprüft werden
%Verarbeitet Klicks auf die Rechtecke im TicTacToe-Board
    h = findobj('Name','viergewinnt');
    h.UserData.m = obj.UserData; %geklickte Spalte %das ist der lineare Index des geklickten Rechtecks
    h.UserData.b(h.UserData.m)=h.UserData.p; %entsprechenden Wert (1/-1) dort ins board schreiben
    %updateBoard(h); %geht, aber dann wird alles neu gezeichnet -> langsam
    showGuiMove(h,h.UserData.m,h.UserData.p); %den neuen Mark anzeigen
    uiresume(h);
end


function showGuiMove(h,linIndex,playerType)
    if playerType == 1
        color = [1 0 0];
    else
        color = [0 1 0];
    end
    [i,j]=ind2sub(size(h.UserData.b),linIndex);
    %schlussposition = [i-0.5 j-0.5 1 1];
    %startposition = [i-0.5 6 1 1];
    
    for k = 1:10*(6.5-j)
        token = rectangle('Position', [i-0.5 6-(0.1*k) 1 1], 'Curvature', [1 1], 'FaceColor', color);
        pause(0.01);
        delete(token);
    end
    
    %rectangle('Position',startposition, 'Curvature', [1 1], 'FaceColor', color);
    %text(i,j,marker,'FontUnits','normalized','FontSize',0.2,'HorizontalAlignment','center');
    %delete(findobj(gca,'Tag','clickable'));
end

function finished(finscore)
    h = findobj('Name','viergewinnt');

    if finscore > 0
        winner = "Rot";
        bgcolor = [1 0 0 0.7];
    else
        winner = "Grün";
        bgcolor = [0 1 0 0.7];
    end
    rectangle('Position', [0.5 0.5 7 6], 'FaceColor', bgcolor);
    text(4,4.5, ['Der Gewinner ist: ' + winner], 'FontSize', 25, 'HorizontalAlignment', 'center');
    
    %Restart-Button
    rectangle('Position', [3 2.8 2 0.8], 'FaceColor', [0.2 0.2 0.2], 'Tag','clickable','ButtonDownFcn',@restart);
    text(4,3.2, ['neu starten'], 'FontSize', 18, 'HorizontalAlignment', 'center', 'Color', [1 1 1], 'Tag','clickable','ButtonDownFcn',@restart);
    
    rectangle('Position', [3 1.6 2 0.8], 'FaceColor', [0.2 0.2 0.2], 'Tag','clickable','ButtonDownFcn',@quit);
    text(4,2, ['beenden'], 'FontSize', 18, 'HorizontalAlignment', 'center', 'Color', [1 1 1], 'Tag','clickable','ButtonDownFcn',@quit);
    
    uiwait(h);
    
    drawnow
end

function restart(obj,evt,h)
    h = findobj('Name','viergewinnt');
    h.UserData.b = zeros(7,6);
    updateBoard(h)
end

function quit(obj,evt,h)
    h = findobj('Name','viergewinnt');
    close(h)
end