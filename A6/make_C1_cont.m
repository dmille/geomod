function [out_cp] = make_C1_cont(control_points)
%make_C1_cont Summary of this function goes here
%   function takes existing peice-wise bezier control points and makes the
%   stitched curve c1 continuous using least squares regression at knot
%   point. 

n = length(control_points);
k = (n - 1)/3;
out_cp = zeros(n,2);

for j=2:k
    % get the index in all_cp for knot that starts bezier curve j (1,4,7...)
    k_ind = 3*j-2;
       
    % pull out 3 control points used for this interation of c1.
    c1_3pts = control_points(k_ind-1:k_ind+1,1:2);
    
    % if all 3 points have same x, just change y values.
    if (c1_3pts(1,1) == c1_3pts(2,1) && c1_3pts(2,1) == c1_3pts(3,1))
        split_diffy = (abs(c1_3pts(2,2) - c1_3pts(1,2)) - abs(c1_3pts(3,2) - c1_3pts(2,2)))/2;
        
        if (c1_3pts(3,2) > c1_3pts(1,2))
            c1_3pts(1,2) = c1_3pts(1,2) + split_diffy;
            c1_3pts(3,2) = c1_3pts(3,2) + split_diffy;
        else
            c1_3pts(1,2) = c1_3pts(1,2) - split_diffy;
            c1_3pts(3,2) = c1_3pts(3,2) - split_diffy;
        end
        
    else
        % use linear least squares for shift to c1 continuous
        A = lin_least_squares(c1_3pts);
         
        % A is intercept and slope of the least squares line for the knot and
        % the 2 control points on either side. 
        % Snap control points to this line using intersection of point slope with slope=(1/A(2))
        b = A(1);
        m = A(2);
        c1_3pts(:,1) = ((1/m)*c1_3pts(:,1)+c1_3pts(:,2)-b)/(m+1/m);
        c1_3pts(:,2) = [ones(3,1) c1_3pts(:,1)] * A;
        
        %plot(c1_3pts(:,1),c1_3pts(:,2),'o','markeredgecolor','r');

        % find the difference in x between neighboring points. split to be added or
        % subtracted to make equal for c1 continuity
        split_diffx = (abs(c1_3pts(2,1) - c1_3pts(1,1)) - abs(c1_3pts(3,1) - c1_3pts(2,1)))/2;

        % move x values so equadistant to middle point
        if (c1_3pts(3,1) > c1_3pts(1,1))
            c1_3pts(1,1) = c1_3pts(1,1) + split_diffx;
            c1_3pts(3,1) = c1_3pts(3,1) + split_diffx;
        else
            c1_3pts(1,1) = c1_3pts(1,1) - split_diffx;
            c1_3pts(3,1) = c1_3pts(3,1) - split_diffx;
        end

        % get new y values for 1 and 3 after x shift
        c1_3pts(:,2) = [ones(3,1) c1_3pts(:,1)] * A;
        
        plot(c1_3pts(:,1),c1_3pts(:,2),'o','markeredgecolor','r');
    end
    
    out_cp(k_ind-1:k_ind+1,1:2) = c1_3pts;
    
    if (control_points(1,1:2) ~= control_points(end,1:2))
        out_cp(1,1:2) = control_points(1,1:2);
        out_cp(2,1:2) = control_points(2,1:2);
        out_cp(end-1,1:2) = control_points(end-1,1:2);
        out_cp(end,1:2) = control_points(end,1:2);
    end
end

% if close, first is second last point, first point, second point
if (control_points(1,1:2) == control_points(end,1:2))
    c1_3pts = [control_points(end-1,1:2);control_points(1,1:2);control_points(2,1:2)];
    
    % if all 3 points have same x, just change y values.
    if (c1_3pts(1,1) == c1_3pts(2,1) && c1_3pts(2,1) == c1_3pts(3,1))
        split_diffy = (abs(c1_3pts(2,2) - c1_3pts(1,2)) - abs(c1_3pts(3,2) - c1_3pts(2,2)))/2;
        
        if (c1_3pts(3,2) > c1_3pts(1,2))
            c1_3pts(1,2) = c1_3pts(1,2) + split_diffy;
            c1_3pts(3,2) = c1_3pts(3,2) + split_diffy;
        else
            c1_3pts(1,2) = c1_3pts(1,2) - split_diffy;
            c1_3pts(3,2) = c1_3pts(3,2) - split_diffy;
        end
        
    else
        % use linear least squares for shift to c1 continuous
        A = lin_least_squares(c1_3pts);
        
        % A is intercept and slope of the least squares line for the knot and
        % the 2 control points on either side. 
        % Snap control points to this line using intersection of point slope with slope=(1/A(2))
        b = A(1);
        m = A(2);
        c1_3pts(:,1) = ((1/m)*c1_3pts(:,1)+c1_3pts(:,2)-b)/(m+1/m);
        c1_3pts(:,2) = [ones(3,1) c1_3pts(:,1)] * A;

        % find the difference in x between neighboring points. split to be added or
        % subtracted to make equal for c1 continuity
        split_diffx = (abs(c1_3pts(2,1) - c1_3pts(1,1)) - abs(c1_3pts(3,1) - c1_3pts(2,1)))/2;

        % move x values so equadistant to middle point
        if (c1_3pts(3,1) > c1_3pts(1,1))
            c1_3pts(1,1) = c1_3pts(1,1) + split_diffx;
            c1_3pts(3,1) = c1_3pts(3,1) + split_diffx;
        else
            c1_3pts(1,1) = c1_3pts(1,1) - split_diffx;
            c1_3pts(3,1) = c1_3pts(3,1) - split_diffx;
        end

        % get new y values for 1 and 3 after x shift
        c1_3pts(:,2) = [ones(3,1) c1_3pts(:,1)] * A;
    end
    
    out_cp(end-1,1:2) = c1_3pts(1,1:2);
    out_cp(end,1:2) = c1_3pts(2,1:2);
    out_cp(1,1:2) = c1_3pts(2,1:2);
    out_cp(2,1:2) = c1_3pts(3,1:2);
end



