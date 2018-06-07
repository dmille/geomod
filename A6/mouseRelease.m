function mouseRelease(varargin)
                                %global myhandles;
  myhandles = guidata(gcbo);

  myhandles.dragStyle=0;
  myhandles.dragedControlPoint=0;
  guidata(gcbo,myhandles) 
end
