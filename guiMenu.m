function [mode, level] = guiMenu()
   
    h = findobj('Name','4 Gewinnt');
    if isempty(h)
        h = figure('NumberTitle', 'off', 'Name','4 Gewinnt','ToolBar','none','MenuBar','none');
        set(h, 'Position', get(h,'Position').*[1 1 0 0] + [0 0 450 450]);
        axis off;  % prepare to draw 
        axis square;
        xlim([0.5 7.5]); ylim([0.5 7.5]);    
    end
    
    axis off;  % prepare to draw 
    axis square;
    xlim([0.5 7.5]); ylim([0.5 7.5]);
    
    %Titel
    text(3.8,7, '4 Gewinnt', 'FontSize', 43, 'HorizontalAlignment', 'center', 'Color', [0 0 0]);
    
    %Abtrennstrich
    rectangle('Position',[0 5.8 7.2 0.05],'LineWidth',0.3, 'FaceColor', [0 0 0], 'EdgeColor', [0 0 0])
    
    %%%%%%%1 Spieler Menü
    text(0.5,5, '1 Spieler', 'FontSize', 21, 'HorizontalAlignment', 'left', 'Color', [0 0 0]);
    %Level-Auswahl
    h.UserData.level = 1;   %Standard-Level setzen
    text(4.05,5.4, 'Schwierigkeit der KI', 'FontSize', 13, 'HorizontalAlignment', 'center', 'Color', [0 0 0]);
    h.UserData.level1 = text(3.1,4.9, ' 1 ', 'FontSize', 16, 'HorizontalAlignment', 'left', 'Color', [1 1 1], 'BackgroundColor', [0 0 0], 'Margin', 4, 'Tag','clickable', 'ButtonDownFcn', {@level, h, 1});
    h.UserData.level2 = text(3.9,4.9, ' 2 ', 'FontSize', 16, 'HorizontalAlignment', 'left', 'Color', [1 1 1], 'BackgroundColor', [0.4 0.4 0.4], 'Margin', 4, 'Tag','clickable', 'ButtonDownFcn', {@level, h, 2});
    h.UserData.level3 = text(4.7,4.9, ' 3 ', 'FontSize', 16, 'HorizontalAlignment', 'left', 'Color', [1 1 1], 'BackgroundColor', [0.4 0.4 0.4], 'Margin', 4, 'Tag','clickable', 'ButtonDownFcn', {@level, h, 3});
    text(7,5, 'Start', 'FontSize', 18, 'HorizontalAlignment', 'right', 'Color', [1 1 1], 'BackgroundColor', [0 0 0], 'Margin', 8, 'Tag','clickable', 'ButtonDownFcn', {@mode, h, '1 Spieler'});
    
    %Abtrennstrich
    rectangle('Position',[0 4.1 7.2 0.03],'LineWidth',0.1, 'FaceColor', [0.6 0.6 0.6], 'EdgeColor', [0.6 0.6 0.6])
    
    %%%%%%%2 Spieler Menü
    text(0.5,3.3, '2 Spieler', 'FontSize', 21, 'HorizontalAlignment', 'left', 'Color', [0 0 0])
    %text(4.1,3, '2 Spieler gegeneinander', 'FontSize', 13, 'HorizontalAlignment', 'center', 'Color', [0 0 0]);
    text(7,3.3, 'Start', 'FontSize', 18, 'HorizontalAlignment', 'right', 'Color', [1 1 1], 'BackgroundColor', [0 0 0], 'Margin', 8, 'Tag','clickable', 'ButtonDownFcn', {@mode, h, '2 Spieler'})
    
    %Abtrennstrich
    rectangle('Position',[0 2.4 7.2 0.05],'LineWidth',0.3, 'FaceColor', [0 0 0], 'EdgeColor', [0 0 0])
    
    %Spiel beenden
    text(4,1.6, 'Beenden', 'FontSize', 17, 'HorizontalAlignment', 'center', 'Color', [1 1 1], 'BackgroundColor', [0 0 0], 'Margin', 4, 'Tag','clickable','ButtonDownFcn',@quit)
    
    %Credits
    credits = "Michel Sabbatini & Simona Borghi" + newline + "EF Informatik | Nicolas Ruh | NKSA" + newline + "09.02.2020";
    text(4,0.2, credits, 'FontSize', 15, 'HorizontalAlignment', 'center', 'Color', [0 0 0])
    
    uiwait()    %warten, bis Starten-Button gedrückt wurde
    mode = h.UserData.mode;
    level = h.UserData.level;
    return
    
end


function mode(obj, evt, h, mode)
    h = findobj('Name','4 Gewinnt');
    h.UserData.mode = mode;
    uiresume(h)
end

function quit(obj, evt)
    h = findobj('Name','4 Gewinnt');
    close(h)
end

function level(obj, evt, h, level)
    h = findobj('Name','4 Gewinnt');
    h.UserData.level = level;
    disp(level)
    %Buttons färben
    set(h.UserData.level1, 'BackgroundColor', [0.4 0.4 0.4]);
    set(h.UserData.level2, 'BackgroundColor', [0.4 0.4 0.4]);
    set(h.UserData.level3, 'BackgroundColor', [0.4 0.4 0.4]);
    if level == 1
        set(h.UserData.level1, 'BackgroundColor', [0 0 0]);
    elseif level == 2
        set(h.UserData.level2, 'BackgroundColor', [0 0 0]);
    elseif level == 3
        set(h.UserData.level3, 'BackgroundColor', [0 0 0]);
    end
end

    
    
    
    
    