function updatePlot
  %%global myhandles;
  myhandles = guidata(gcbo);

  
  %% UPDATE NOISY DATA
  if myhandles.noisy_plot == 0
    myhandles.noisy_plot = plot(myhandles.noisy_data(:,1), myhandles.noisy_data(:,2), '-r');

  else
    set(myhandles.noisy_plot, 'Xdata', myhandles.noisy_data(:,1));
    set(myhandles.noisy_plot, 'Ydata', myhandles.noisy_data(:,2));
  end

  bezier_count = count_beziers(); %number of bezier curves

  
  %% UPDATE BEZIER CONTROL POLYGONS
  if bezier_count > 1
    %% if first time, new plot
    if myhandles.bezier_plot == 0  % draw beziers for the first time
      myhandles.bezier_plot = plot(myhandles.bezier_controlPts(:,1),myhandles.bezier_controlPts(:,2),'-o',...
                                   'color',[.4,.4,.4],...
                                   'LineWidth',1,...
                                   'MarkerSize',8,...
                                   'MarkerEdgeColor','green',...
                                   'MarkerFaceColor',[0.5,0.5,0.75]);
      %% Otherwise, update the plot
    else
      for i=[1:bezier_count]
        set(myhandles.bezier_plot,'Xdata',myhandles.bezier_controlPts(:,1));
        set(myhandles.bezier_plot,'Ydata',myhandles.bezier_controlPts(:,2));
      end
    end
  end

  
  %% UPDATE BEZIER CURVES
  if bezier_count > 1
    new_curves = zeros(128,2,0);
    %% Calculate new curves
    for i=[1:bezier_count]
      new_curves(:,:,i) = decasteljau(bezier_ind(myhandles.bezier_controlPts,i) , myhandles.tsampling);
    end

    %% If first time drawn, new plot
    if myhandles.bezier_curves == 0 %draw curve for the first time
      for i=[1:bezier_count]
        myhandles.bezier_curves(i)=plot(new_curves(:,1,i),new_curves(:,2,i),'-g','Linewidth',1);  
      end
      %% if not first time, update plot
    else 
      for i=[1:bezier_count]
        set(myhandles.bezier_curves(i),'Xdata', new_curves(:,1,i));
        set(myhandles.bezier_curves(i),'Ydata', new_curves(:,2,i));
      end
    end
  end

  %% update the handles data
  guidata(gcbo,myhandles);
end
