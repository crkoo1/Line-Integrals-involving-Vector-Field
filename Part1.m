%-------------------------------------------------------------------------%
% Part 1: Path of the Endurance Spaceship 
% Code for the Path of Spaceship and the Gravitational Field Force 
%clean up all previous data
clear
clc 

% Constant Variable 
G = 6.67 * 10^-11; % gravitational constant
bh_x = - 30*10^6;  % x-coordinate of the black hole
bh_y = - 50*10^6;  % y-coordinate of the black hole
m_spaceship = 15 * 10^6;  % mass of the spaceship
m_blackhole = 1.989 * 10^39; % mass of the blackhole
ss_x_init = 0; 
ss_y_init = 0; 


%-------------------------------------------------------------------------%
% Defining initial distance of the spaceship in space
x_ss = ss_x_init; 
y_ss = ss_y_init; 

% Distance |r|, distance between the blackhole and the spaceship
% Using the Anonymouus function
dis_bh_ss = @(x, y) sqrt((bh_x - x).^2 + (bh_y - y).^2);

% Unit direction vector components
x_comp_r = @(x, y) (bh_x - x) ./ dis_bh_ss(x, y);
y_comp_r = @(x, y) (bh_y - y) ./ dis_bh_ss(x, y);

% Magnitude of the gravitational force field due to blackhole
force_magnitude = @(x, y) G * m_blackhole * m_spaceship ./ dis_bh_ss(x, y).^2;

% Display the functions to ensure they are correctly defined
disp(x_comp_r);
disp(y_comp_r);
disp(force_magnitude);

%-------------------------------------------------------------------------%
% Part 1 b, Using MATLAB function quiver to plot the gravitational force
% field 

% Parametric equations for the path which changes with respect to time, t
x_t = @(t) 30e6 * cos(t) - 30e6;
y_t = @(t) 40e6 * sin(t);

% Define the grid for quiver plot as per formula 
[x, y] = meshgrid(linspace(-60e6, 40e6, 20), linspace(0, 100e6, 20));

% Force components
% Defining the forces as distance changes 
Fx = @(x, y) - G * m_blackhole * m_spaceship * (x - bh_x) ./ dis_bh_ss(x, y).^3;
Fy = @(x, y) - G * m_blackhole * m_spaceship * (y - bh_y) ./ dis_bh_ss(x, y).^3;

% Calculate the force vectors 
% Used U and V so that it fits the quiver function
U = Fx(x, y);
V = Fy(x, y);

% Plot the gravitational force field using quiver
% lots arrows with directional components U and V 
% at the Cartesian coordinates specified by X and Y. 
figure;
quiver(x, y, U, V);
hold on;

% Calculate the path of the spaceship
% Plotting the x_coordinates (x_val) and y_coordinates (y_val) as time
% changes (t_vals) 
t_vals = linspace(0, 2.5, 1000);
x_vals = x_t(t_vals);
y_vals = y_t(t_vals);

% Plot the path of the spaceship
% Plot() creates a 2-D line plot of the data in Y versus the corresponding values in X.
plot(x_vals, y_vals, 'r', 'LineWidth', 1.5);

% Add markers for the start point, end point, and t = 1.6
% Scatter is function used to plot scatter points
scatter(x_vals(1), y_vals(1), 'g', 'filled'); % start point
scatter(x_vals(end), y_vals(end), 'b', 'filled', '>'); % end point with arrow using marker 
t_marker = 1.6; % Finding the x and y coordinates when t = 1.6 
x_marker = x_t(t_marker);
y_marker = y_t(t_marker);
scatter(x_marker, y_marker, 'm', 'filled'); % t = 1.6

% Label the points
% text() Adds a text description to one or more data points 
% in the current axes using the text specified by txt.
text(x_vals(1), y_vals(1), ' Start', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(x_vals(end), y_vals(end), ' End', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(x_marker, y_marker, ' t = 1.6', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

% Set axis limits
axis([-60e6 40e6 0 100e6]);

% Titles and labels
title('Gravitational Force Field and Path of the Spaceship');
xlabel('X (meters)');
ylabel('Y (meters)');
legend({'Force Field', 'Path of the Spaceship'}, 'Location', 'northeast');
hold off;
