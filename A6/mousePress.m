function mousePress(varargin)
  %% Mouse button pressed
  % get the variables stored in handles
  myhandles = guidata(gcbo);
  closeEnough=.02;
  %% Three different possible mouse presses
  %% Left Button: Control Point Dragged
  if strcmp(get(gcf,'SelectionType'),'alt')
    currentpos=get(myhandles.axis,'CurrentPoint');
    currentpos=currentpos(1,1:2);
%    if min(currentpos) >= 0 && max(currentpos) <=1 % within the axis
              % get closest control point to the current mous position
    [mindist,minindx]=min((currentpos(1)-myhandles.bezier_controlPts(:,1)).^2+(currentpos(2)-myhandles.bezier_controlPts(:,2)).^2);
      if mindist < closeEnough % only update when the the user clicks neer control points
        myhandles.dragStyle=1; 
        myhandles.dragedControlPoint=minindx;
        myhandles.bezier_controlPts(minindx,:)=currentpos;
        
        guidata(gcbo,myhandles); % update data in handles
      end
%    end
  end

                                % Right Button: Nothing
  if strcmp(get(gcf,'SelectionType'),'alt')
    
  end

                                % Middle Button: Nothing
  if strcmp(get(gcf,'SelectionType'),'extend')
    
  end

  %% Update Plot
  updatePlot;
end
