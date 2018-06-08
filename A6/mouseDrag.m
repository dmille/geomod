function mouseDrag(varargin)
  %% global myhandles;
  myhandles = guidata(gcbo);

  if myhandles.dragStyle
    p=get(myhandles.axis,'CurrentPoint');
    p=p(1,1:2);
    if min(p) >= 0 & max(p) <=1 
      myhandles.bezier_controlPts(myhandles.dragedControlPoint,:)=p;
      guidata(gcbo,myhandles);

      updatePlot;
    end 
  end
end
