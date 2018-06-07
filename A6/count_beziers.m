  function count=count_beziers(varargin)
    myhandles = guidata(gcbo);
    count=(size(myhandles.bezier_controlPts,1) - 1)/3
  end
