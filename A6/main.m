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

myhandles.bezier_controlPts = zeros(4,2,0);
myhandles.bezier_plots = 0;
myhandles.bezier_curves = 0;
%% Test Control Points %%%%%%%%%%%%%%%
control_1 = [1,1; 2,5; 5,5; 5,1];
control_2 = [5,2; 3,8; 2,9; 9,9];
myhandles.bezier_controlPts(:,:,1) = control_1;
myhandles.bezier_controlPts(:,:,2) = control_2;
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

%%% Callback Functions %%%

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
  
% Reset button callback
function reset(varargin) 
%global myhandles;
myhandles = guidata(gcbo);

myhandles.noisy_data = 0;
myhandles.noisy_plot = 0;

updatePlot;
%%

%%=======================================================================%%
%%                            Mouse actions                              %%
%%=======================================================================%%


%% Mouse button pressed
function mousePress(varargin)

% get the variables stored in handles
myhandles = guidata(gcbo);
closeEnough=.02;

% Three different possible mouse presses

% Left Button: Control Point Dragged
if strcmp(get(gcf,'SelectionType'),'normal')
    currentpos=get(myhandles.axis,'CurrentPoint');
  currentpos=currentpos(1,1:2);  
  if min(currentpos) >= 0 && max(currentpos) <=1 % within the axis
    % get closest control point to the current mous position
    [mindist,minindx]=min((currentpos(1)-myhandles.controlPts(:,1)).^2+(currentpos(2)-myhandles.controlPts(:,2)).^2);
    if mindist < closeEnough % only update when the the user clicks neer control points
      myhandles.dragStyle=1; 
      myhandles.dragedControlPoint=minindx;
      myhandles.controlPts(minindx,:)=currentpos;
      
      guidata(gcbo,myhandles) % update data in handles
    end
  end
end

% Right Button: Nothing
if strcmp(get(gcf,'SelectionType'),'alt')
  
end

% Middle Button: Nothing
if strcmp(get(gcf,'SelectionType'),'extend')
  
end

%% Update Plot
updatePlot;

% Mouse button released
function mouseRelease(varargin)
%global myhandles;
myhandles = guidata(gcbo);

myhandles.dragStyle=0;
myhandles.dragedControlPoint=0;
guidata(gcbo,myhandles) 

% Mouse being moved (after clicking)
function mouseDrag(varargin)
%global myhandles;
myhandles = guidata(gcbo);

if myhandles.dragStyle
  p=get(myhandles.axis,'CurrentPoint');
  p=p(1,1:2);
  if min(p) >= 0 & max(p) <=1 
    myhandles.controlPts(myhandles.dragedControlPoint,:)=p;
    guidata(gcbo,myhandles) 

    updatePlot;
  end 
end 

%%=======================================================================%%
%%                             update plot                               %%
%%=======================================================================%%

%% Update the plot
function updatePlot
%global myhandles;
myhandles = guidata(gcbo);


%% Plot the noisy data
if myhandles.noisy_plot == 0
  myhandles.noisy_plot = plot(myhandles.noisy_data(:,1), myhandles.noisy_data(:,2), '-r');

else
  set(myhandles.noisy_plot, 'Xdata', myhandles.noisy_data(:,1));
  set(myhandles.noisy_plot, 'Ydata', myhandles.noisy_data(:,2));
end

bezier_count = size(myhandles.bezier_controlPts,3);%number of beziers

%decide when to draw/update the control points
if bezier_count > 0
  % draw bezier
  if myhandles.bezier_plots == 0  % draw beziers for the first time
    for i=[1:bezier_count]
      myhandles.bezier_plots(i) = plot(myhandles.bezier_controlPts(:,1,i),myhandles.bezier_controlPts(:,2,i),'-o',...
                                       'color',[.4,.4,.4],...
                                       'LineWidth',1,...
                                       'MarkerSize',8,...
                                       'MarkerEdgeColor','green',...
                                       'MarkerFaceColor',[0.5,0.5,0.75]);
    end
  else
    for i=[1:bezier_count]
      set(myhandles.bezier_plots(i),'Xdata',myhandles.bezier_controlPts(:,1,i));
      set(myhandles.bezier_plots(i),'Ydata',myhandles.bezier_controlPts(:,2,i));
    end
  end
end

if bezier_count > 1
  new_curves = zeros(128,2,0);
   % draw curve
  for i=[1:bezier_count]
    new_curves(:,:,i) = decasteljau(myhandles.bezier_controlPts(:,:,i) , myhandles.tsampling);
  end
  %%
    size(new_curves)
  if myhandles.bezier_curves == 0 %draw curve for the first time
    for i=[1:bezier_count]
      myhandles.bezier_curves(i)=plot(new_curves(:,1,i),new_curves(:,2,i),'-g','Linewidth',1);  
    end
  else %update curve
    for i=[1:bezier_count]
      set(myhandles.bezier_curves(i),'Xdata', new_curves(:,1,i));
      set(myhandles.bezier_curves(i),'Ydata', new_curves(:,2,i));
    end
  end
end

%update the handles data
guidata(gcbo,myhandles) 

 

function new_curves= decasteljau(controlPts,tsampling);

%define your function here for 4.1 a
 %%============================your code==================================== 
     if(size(controlPts,1) == 1)
        new_curves = controlPts;
    else
        new_curves = (1 - tsampling) .* decasteljau(controlPts(1:end-1,:), tsampling) + tsampling .* decasteljau(controlPts(2:end,:), tsampling);
    end
