function decasteljau_lines(con_pts,t)
hold on
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    if(size(con_pts,1) > 1)
        new_con_pts = (1 - t) .* con_pts(1:end-1,:) + t .* con_pts(2:end,:);
        plot(new_con_pts(:,1), new_con_pts(:,2),'-k+','markeredgecolor','r','markersize',7,'LineWidth',2);
        decasteljau_lines(new_con_pts,t);
    end
end



