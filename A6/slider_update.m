%slider callback
function slider_update(varargin) 
%global myhandles;
myhandles = guidata(gcbo);

%% Read n_beziers value
myhandles.n_beziers = floor(get(myhandles.n_beziers_slider,'Value'));

%% update the value in handles
set(myhandles.n_beziers_slider,'Value',myhandles.n_beziers); 

%% display current value in the text box
set(myhandles.n_beziers_slider_text,'String',sprintf('Number of Beziers: %d',myhandles.n_beziers)); 

%% update plot
myhandles.bezier_controlPts = fit_bezier(myhandles.noisy_data, myhandles.n_beziers)

guidata(gcbo,myhandles) 
updatePlot;
