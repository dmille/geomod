%slider callback
function slider_update(varargin) 
%global myhandles;
myhandles = guidata(gcbo);

%% Read t value
myhandles.n_beziers = floor(get(myhandles.n_beziers_slider,'Value'));
set(myhandles.n_beziers_slider,'Value',myhandles.n_beziers); %update the value in handles
% display current value in the text box
%set(myhandles.n_beziers_slider_text,'String',sprintf('t=%4.2f',myhandles.t)); 

%% make the text box follow the slider :)
%txtpos=get(myhandles.t_slider_text,'position');
sliderpos=get(myhandles.n_beziers_slider,'position');
%txtpos(1)=sliderpos(1)+myhandles.n_beziers*(sliderpos(3)-.05);
%set(myhandles.t_slider_text,'position',txtpos);
%% update plot
myhandles.bezier_controlPts = fit_bezier(myhandles.noisy_data, myhandles.n_beziers)

guidata(gcbo,myhandles) 
updatePlot;
