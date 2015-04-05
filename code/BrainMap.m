function BrainMap(channels, brain_x, brain_y, mx, my)
%function BrainMap(channels, brain_x, brain_y, mx, my)
%channels - channel weights
%brain_x - x co-ordinates on brain picture
%brain_y - y co-ordinates on brain picture
% In the m file there's the mask for the electrode positions for participants 
% A and B (x_full and y_full) who used all 62 electrodes. There's also brain_x_C, 
% brain_x_D, brain_x_E and brain_y_C, brain_y_D, brain_y_E for participants C,D 
% and E who didn't have the full 62 channels being used.

brain_x = floor(brain_x);
brain_y = floor(brain_y);


I = zeros(397,392);
N = 256;

%Normalize Data
if (min(channels(:)) <0),
    channels = (channels - min(channels(:)) );
end
channels= channels./(max(channels(:)));

channels = [channels ; min(channels).*ones(1089,1)];


% %Set Image values equal to input values
% for i = 1:length(brain_x)
%   I(brain_x(i),brain_y(i))=channels(i);
% end

cx=brain_y;cy=brain_x;
brain_x=[brain_x ; my];
brain_y=[brain_y ; mx];

%interpolate
x = 1:397;
y = 1:392;
[xx,yy] = meshgrid(x,y);
z = griddata(brain_x,brain_y,channels,xx,yy,'cubic');


% %Adjust colorbar to include black background
ma=max(z(:));
mi=min(z(:));
step=(ma-mi)/(N-2);
white= mi + (-1)*step;
black =ma + step;
z(isnan(z))=white;

%Set Electrode sites equal to black
e_size = 1;
e_col = white;
for i=1:length(cx)
    z(cx(i),cy(i))=e_col;
    z(cx(i)+e_size,cy(i))=e_col;
    z(cx(i)-e_size,cy(i))=e_col;
    z(cx(i)-e_size,cy(i)-e_size)=e_col;
    z(cx(i),cy(i)-e_size)=e_col;
    z(cx(i)+e_size,cy(i)-e_size)=e_col;
    z(cx(i)-e_size,cy(i)+e_size)=e_col;
    z(cx(i),cy(i)+e_size)=e_col;
    z(cx(i)+e_size,cy(i)+e_size)=e_col;
end

z = imadjust(z);

%Display
figure;imshow(z);
map=colormap(jet(N));
map(1,:)=[1 1 1];
map(2,:) = [0 0 0];
colormap(map)
colorbar('WestOutside','fontsize',8,'fontname','arial','ytick',[0 0.5 1],'yticklabel',[]);
