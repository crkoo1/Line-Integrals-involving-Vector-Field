%-------------------------------------------------------------------------%
% Part 1: Calculation of the Work Performed by the Gravitaional Field
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

% Parametric equations for the path using anonymouus function
x_t = @(t) 30e6 * cos(t) - 30e6;
y_t = @(t) 40e6 * sin(t);
y_t2 = @(t) 40e6 * sin(t) - 20e6 * t.^2 + 50e6 * t; 

%-------------------------------------------------------------------------%
% Part 2: Calculation of Work Performed by the Gravitational Field 

% Defining a few equations and formulas used from previous part. 
% Defining initial distance of the spaceship in space
x_ss = ss_x_init; 
y_ss = ss_y_init; 

% Distance |r|, distance between the blackhole and the spaceship
% Using the Anonymouus function
dis_bh_ss = @(x,y) sqrt((bh_x - x).^2 + (bh_y - y).^2);


% Unit direction vector components
x_comp_r = @(x, y) (bh_x - x) ./ dis_bh_ss(x, y);
y_comp_r = @(x, y) (bh_y - y) ./ dis_bh_ss(x, y);

% Magnitude of the gravitational force field due to black hole
force_magnitude = @(x, y) G * m_blackhole * m_spaceship ./ dis_bh_ss(x, y).^2;

% Force components using anonymous functions
force_x = @(x, y) force_magnitude(x, y) .* x_comp_r(x, y); 
force_y = @(x, y) force_magnitude(x, y) .* y_comp_r(x, y); 

% Force components along the parametric path
Fx_t = @(t) force_x(x_t(t), y_t(t));
Fy_t = @(t) force_y(x_t(t), y_t(t));
Fx2_t = @(t) force_x(x_t(t), y_t2(t)); % for part d 
Fy2_t = @(t) force_y(x_t(t), y_t2(t)); % for part d 

% Derivatives of the path using anonymous functions
dx_dt = @(t) -30e6 * sin(t);
dy_dt = @(t) 40e6 * cos(t); 
dy_dt2 = @(t) 40e6 * cos(t) - 40e6 * t + 50e6; % for part d 

% Dot product of the force and the derivative of the path
F_dot_dr = @(t) Fx_t(t) .* dx_dt(t) + Fy_t(t) .* dy_dt(t);
F_dot_dr2 = @(t) Fx2_t(t) .* dx_dt(t) + Fy2_t(t) .* dy_dt2(t); % for part d 

% Integrate the work using integral
% Work from t = 0 to t = 2.5
W_total = integral(F_dot_dr, 0, 2.5);

% Work from t = 1.6 to t = 2.5
W_partial = integral(F_dot_dr, 1.6, 2.5);

% Work from t = 0 to t = 2.5 for part d
W_total2 = integral(F_dot_dr2, 0, 2.5);

% Convert to Yotta Joules (YJ)
W_total_YJ = W_total * 1e-24;
W_partial_YJ = W_partial * 1e-24;
W_total2_YJ = W_total2 * 1e-24; % for part d 

% Display results
fprintf('Work performed by the gravitational field (0 <= t <= 2.5) for first path: %.4f YJ\n', W_total_YJ);
fprintf('Work performed by the gravitational field (1.6 <= t <= 2.5) for first path: %.4f YJ\n', W_partial_YJ);
fprintf('Work performed by the gravitational field (0 <= t <= 2.5) for second path: %.4f YJ\n', W_total2_YJ);


%-------------------------------------------------------------------------%
% Ploting of the Gravitational Force Field and Path of the Spaceship

% Define the grid for quiver plot
[x_grid, y_grid] = meshgrid(linspace(-60e6, 40e6, 20), linspace(0, 100e6, 20));

% Calculate force vectors on the grid
U = - G * m_blackhole * m_spaceship * (x_grid - bh_x) ./ (dis_bh_ss(x_grid, y_grid).^3);
V = - G * m_blackhole * m_spaceship * (y_grid - bh_y) ./ (dis_bh_ss(x_grid, y_grid).^3);

% Plot the gravitational force field using quiver
figure;
quiver(x_grid, y_grid, U, V);
hold on;

% Calculate the path of the spaceship
t_vals = linspace(0, 2.5, 1000);
x_vals = x_t(t_vals);
y_vals = y_t(t_vals);
x_vals2 = x_t(t_vals); % for part d 
y_vals2 = y_t2(t_vals); % for part d 

% Plot the path of the spaceship
plot(x_vals, y_vals, 'r', 'LineWidth', 1.5);
plot(x_vals2, y_vals2, 'b', 'LineWidth', 1.5); % for part d 

% Add markers for the start point, end point, and t = 1.6
scatter(x_vals(1), y_vals(1), 'b', 'filled'); % start point
scatter(x_vals(end), y_vals(end), 'b', 'filled', '>'); % end point
scatter(x_vals2(1), y_vals2(1), 'g', 'filled'); % start point of second path % for part d 
scatter(x_vals2(end), y_vals2(end), 'g', 'filled', '>'); % end point of second path % for part d 

% Getting the midpoints
t_marker = 1.6;
x_marker = x_t(t_marker);
y_marker = y_t(t_marker);
x_marker2 = x_t(t_marker); % for part d 
y_marker2 = y_t2(t_marker); % for part d 
scatter(x_marker, y_marker, 'b', 'filled', 's'); % t = 1.6
scatter(x_marker2, y_marker2, 'g', 'filled', 's'); % t = 1.6 % for part d 

% Label the points
text(x_vals(1), y_vals(1), ' Start', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(x_vals(end), y_vals(end), ' End', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(x_marker, y_marker, ' t = 1.6', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
text(x_vals2(1), y_vals2(1), ' Start', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right'); % for part d 
text(x_vals2(end), y_vals2(end), ' End', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right'); % for part d 
text(x_marker2, y_marker2, ' t = 1.6', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right'); % for part d 

% Set axis limits
axis([-60e6 40e6 0 100e6]);

% Titles and labels
title('Gravitational Force Field and Path of the Endurance Spaceship');
xlabel('X (meters)');
ylabel('Y (meters)');
legend({'Force Field', 'First Path of the Spaceship', 'New Path of the Spaceship', ...
    'Start Point of first path', 'End Point of first path', 'Start Point of new path', ...
    'End Point of new path', 'Mid Point of first path', 'Start Point of new path'}, ...
    'Location', 'northeast');

hold off;


