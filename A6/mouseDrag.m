function mouseDrag(varargin)
% global myhandles;
    myhandles = guidata(gcbo);

    if myhandles.dragStyle
        p=get(myhandles.axis,'CurrentPoint');
        p=p(1,1:2);

        m = size(myhandles.bezier_controlPts, 1);
        
        previous_location = myhandles.bezier_controlPts(myhandles.dragedControlPoint,:);

        drag_vec = p - previous_location;
        
        % test whether point is knot point or not
        if(mod(myhandles.dragedControlPoint - 1, 3) == 0)
            % Dragged point is a knot point
            if( myhandles.dragedControlPoint == 1)
                % dragged knot point is the first point
                myhandles.bezier_controlPts(myhandles.dragedControlPoint + 1, :) = myhandles.bezier_controlPts(myhandles.dragedControlPoint + 1, :) + drag_vec;

            elseif( myhandles.dragedControlPoint == m)
                % dragged knot point is the last point
                myhandles.bezier_controlPts(myhandles.dragedControlPoint - 1, :) = myhandles.bezier_controlPts(myhandles.dragedControlPoint - 1, :) + drag_vec;         
            else
                % dragged knot point is neither last or first point
                myhandles.bezier_controlPts(myhandles.dragedControlPoint + 1, :) = myhandles.bezier_controlPts(myhandles.dragedControlPoint + 1, :) + drag_vec;
                myhandles.bezier_controlPts(myhandles.dragedControlPoint - 1, :) = myhandles.bezier_controlPts(myhandles.dragedControlPoint - 1, :) + drag_vec;
            end
        else
            % Dragged point is NOT a knot point

            % Which is the adjacent knot point?
            if( mod(myhandles.dragedControlPoint - 2, 3) == 0)
                % The Previous point is the knot
                if( myhandles.dragedControlPoint - 1 ~= 1)
                    % Only move other point if the adjacent knot is not an endpoint
                    % Index of other point: dragedControlPoint - 2
                    %myhandles.bezier_controlPts(myhandles.dragedControlPoint - 2, :) = myhandles.bezier_controlPts(myhandles.dragedControlPoint - 2, :) - drag_vec;
                    myhandles.bezier_controlPts(myhandles.dragedControlPoint - 2, :) = 2*myhandles.bezier_controlPts(myhandles.dragedControlPoint - 1, :) - p;
                end       
            else
                % The Next point is the knot
                if( myhandles.dragedControlPoint + 1 ~= m)
                    % Only move other point if the adjacent knot is not an endpoint
                    % Index of other point: dragedControlPoint + 2
                    myhandles.bezier_controlPts(myhandles.dragedControlPoint + 2, :) = 2*myhandles.bezier_controlPts(myhandles.dragedControlPoint + 1, :) - p;
                end
            end
        end
        myhandles.bezier_controlPts(myhandles.dragedControlPoint,:)=p;
        guidata(gcbo,myhandles);
        updatePlot;

    end
end
