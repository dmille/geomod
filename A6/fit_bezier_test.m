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
  noisy_data = fscanf(fileID, format, size)';
end

fit_bezier(noisy_data(1:20,:), 5);
