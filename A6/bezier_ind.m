function b_pts = bezier_ind(control_pts,i)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    b0_ind = 3 * (i-1) + 1;
    
    b0 = control_pts(b0_ind,:);
    b1 = control_pts(b0_ind+1,:);
    b2 = control_pts(b0_ind+2,:);
    b3 = control_pts(b0_ind+3,:);
    
    b_pts = [b0;b1;b2;b3];
end
