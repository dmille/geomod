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

  %% Test Control Points %%%%%%%%%%%%%%%
  controlPts = [1,1; 2,5; 5,5; 5,1; 3,8; 2,9; 9,9];
  myhandles.bezier_controlPts = controlPts;
%%%%%%%%%%%%%%%%%%%%

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

                       % reset clear the screen and re-initialize data
  uicontrol('Units','normalized', ...
	        'BackgroundColor','white', ...
            'ForegroundColor','red',...
	        'String','Reset', ...
	        'Position',[.9,.0,.1,.04], ...
	        'Callback',@reset,...
	        'Style','pushbutton');

                                % Open new file
  uicontrol('Units','normalized', ...
	        'BackgroundColor','white', ...
            'ForegroundColor','black',...
	        'String','Open File', ...
	        'Position',[.15,.0,.7,.03], ...
	        'Callback',@open_new_file,...
	        'Style','pushbutton');

                                %save myhandle using guidata 
  guidata(gcf,myhandles) 

                                %d%efine Mouse callbacks
  set(gcf,'WindowButtonDownFcn',@mousePress);
  set(gcf,'WindowButtonMotionFcn',@mouseDrag);
  set(gcf,'WindowButtonUpFcn',@mouseRelease);

                                %open_new_file();

end
