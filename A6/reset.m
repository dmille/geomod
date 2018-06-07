function reset(varargin) 
                                %global myhandles;
  myhandles = guidata(gcbo);

  myhandles.noisy_data = 0;
  myhandles.noisy_plot = 0;

  updatePlot;
  %%
end
