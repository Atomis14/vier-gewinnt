function mode = guiMenu()
   
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
    text(4,6.7, '4 Gewinnt', 'FontSize', 43, 'HorizontalAlignment', 'center', 'Color', [0 0 0]);
    
    %Modus-Auswahl
    text(3.6,4.4, '1 Spieler', 'FontSize', 20, 'HorizontalAlignment', 'right', 'Color', [1 1 1], 'BackgroundColor', [0 0 0], 'Margin', 8, 'Tag','clickable', 'ButtonDownFcn', {@mode, h, '1 Spieler'});
    text(4.4,4.4, '2 Spieler', 'FontSize', 20, 'HorizontalAlignment', 'left', 'Color', [1 1 1], 'BackgroundColor', [0 0 0], 'Margin', 8, 'Tag','clickable', 'ButtonDownFcn', {@mode, h, '2 Spieler'});

    %Spiel beenden
    text(4,3.1, 'Beenden', 'FontSize', 18, 'HorizontalAlignment', 'center', 'Color', [1 1 1], 'BackgroundColor', [0 0 0], 'Tag','clickable','ButtonDownFcn',@quit);
    
    %Credits
    credits = "Michel Sabbatini & Simona Borghi" + newline + "EF Informatik | Nicolas Ruh | NKSA" + newline + "09.02.2020";
    text(4,1.1, credits, 'FontSize', 15, 'HorizontalAlignment', 'center', 'Color', [0 0 0]);
    
    uiwait()
    mode = h.UserData.mode;
    return
    
end


function mode(obj, evt, h, mode)
    h = findobj('Name','4 Gewinnt');
    h.UserData.mode = mode;
    uiresume(h)
end

function quit(obj, evt, h)
    h = findobj('Name','4 Gewinnt');
    close(h)
end