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
    size = [2 Inf];
    fileID = fopen(filepath, 'r');
    myhandles.noisy_data = fscanf(fileID, format, size)';

    guidata(gcbo,myhandles);
    updatePlot;
  end
end
