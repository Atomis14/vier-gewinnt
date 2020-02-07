function animation(h,linIndex,playerType)

    if playerType == 1
        color = [1 0 0];
    else
        color = [0 1 0];
    end
    
    if size(linIndex) == 1  %falls User Stein gesetzt hat
        [i,j]=ind2sub(size(h.UserData.b),linIndex);
        %disp("USER: j: " + j + " | i: " + i)
    else                    %falls KI den Stein gesetzt hat
        i = linIndex(2);            %Spalte
        j = linIndex(1); %Zeile
        %disp("AI: j: " + j + " | i: " + i)
    end
  
    %schlussposition = [i-0.5 j-0.5 1 1];x
    %startposition = [i-0.5 6 1 1];
    
    token = rectangle('Position', [i-0.5 6 1 1], 'Curvature', [1 1], 'FaceColor', color);
    for k = 1:10*(6.5-j)
        set(token, 'Position', [i-0.5 6-(0.1*k) 1 1]);
        %token.position = [i-0.5 6-(0.1*k) 1 1];
        pause(0.01);
    end
    
    %rectangle('Position',startposition, 'Curvature', [1 1], 'FaceColor', color);
    %text(i,j,marker,'FontUnits','normalized','FontSize',0.2,'HorizontalAlignment','center');
    %delete(findobj(gca,'Tag','clickable'));
end