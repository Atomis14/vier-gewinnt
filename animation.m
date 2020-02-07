function animation(h,linIndex,playerType)

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
 
    token = rectangle('Position', [i-0.5 6 1 1], 'Curvature', [1 1], 'FaceColor', color);
    for k = 1:10*(6.5-j)
        set(token, 'Position', [i-0.5 6-(0.1*k) 1 1]);
        pause(0.01);
    end

end