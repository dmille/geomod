function main
                                % main interface

                                % create a new figure 
  figure('Name','Noisy Data Approximater','NumberTitle','off','color','white')


  %% define variables used and store them in handle 
  myhandles=[];

  myhandles.noisy_data=zeros(0,2);
  myhandles.noisy_plot=0;

  myhandles.tsampling = linspace(0,1,128)';

  myhandles.dragStyle=0;
  myhandles.dragedControlPoint=0;
  myhandles.axis=0;

  myhandles.bezier_controlPts = zeros(0,2);
  myhandles.bezier_plot = 0;
  myhandles.bezier_curves = 0;
  myhandles.n_beziers = 50;

  %% design a basic  interface
  % setup axis with a grid layout for drawing 
  hax = gca; %get handle of current axes
  set(hax,'Unit','normalized','Position',[0 0 1 1]); % make axis fill figure
  axis manual; % disable automatic resizing of axis
  grid on 
  grid minor; % draw a fine grid 

  hold on; % keep waiting for more input in the figure

  myhandles.axis=hax;
                                %guidata(gcf,myhandles) 

  %% Open new file
  uicontrol('Units','normalized', ...
	        'BackgroundColor','white', ...
            'ForegroundColor','black',...
	        'String','Open File', ...
	        'Position',[.15,.0,.7,.03], ...
	        'Callback',@open_new_file,...
	        'Style','pushbutton');

  %% Parameter t slider
  myhandles.n_beziers_slider=uicontrol('Units','normalized', ...
	                           'BackgroundColor',get(gcf,'Color'), ...
                               'position',[.25 .05 .5 .05],...
	                           'Min',0,'Max',100,'Value',myhandles.n_beziers,...
	                           'Sliderstep',[0.01,0.1],...
	                           'Callback',@slider_update,...
	                           'Style','slider','Enable','on');

  %% save myhandle using guidata 
  guidata(gcf,myhandles) 

  %% define Mouse callbacks
  set(gcf,'WindowButtonDownFcn',@mousePress);
  set(gcf,'WindowButtonMotionFcn',@mouseDrag);
  set(gcf,'WindowButtonUpFcn',@mouseRelease);

end
