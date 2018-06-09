function open_new_file(varargin)

  myhandles = guidata(gcbo);
  [file,path] = uigetfile('*.txt');
  if isequal(file,0)
    disp('User selected Cancel');
    hold off;
  else
    filepath = fullfile(path,file);
    disp(filepath);
    format = "%f %f";
    data_size = [2 Inf];
    fileID = fopen(filepath, 'r');
    myhandles.noisy_data = fscanf(fileID, format, data_size)';
    m = size(myhandles.noisy_data, 1);

    myhandles.max_beziers = floor(m/5);
    myhandles.n_beziers = floor(myhandles.max_beziers/2);
    set(myhandles.n_beziers_slider, 'Value',myhandles.n_beziers);
    set(myhandles.n_beziers_slider, 'Max', myhandles.max_beziers);
    set(myhandles.n_beziers_slider, 'Sliderstep', [1/myhandles.max_beziers 0.1]);
    set(myhandles.n_beziers_slider_text,'String',sprintf('Number of Beziers: %d',myhandles.n_beziers)); 


    myhandles.bezier_controlPts = fit_bezier(myhandles.noisy_data, myhandles.n_beziers);
    
    guidata(gcbo,myhandles);
    updatePlot;
  end
end
