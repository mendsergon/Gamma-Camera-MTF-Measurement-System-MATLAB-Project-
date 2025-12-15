% MTF Measurement of Gamma Camera
clear; clc; close all;

% 1. Load the phantom image
phantom_img = imread('phantom_C9FF1H.gif');

% Convert to double for calculations
if size(phantom_img, 3) == 3
    phantom_img = rgb2gray(phantom_img);
end
phantom_img = double(phantom_img);

% 2. Get image dimensions and divide into quadrants
[rows, cols] = size(phantom_img);
mid_row = floor(rows/2);
mid_col = floor(cols/2);

% Define quadrants: 
% Top-left: quadrant1, Top-right: quadrant2
% Bottom-left: quadrant3, Bottom-right: quadrant4
quadrant1 = phantom_img(1:mid_row, 1:mid_col);       % Top-left
quadrant2 = phantom_img(1:mid_row, mid_col+1:end);   % Top-right
quadrant3 = phantom_img(mid_row+1:end, 1:mid_col);   % Bottom-left
quadrant4 = phantom_img(mid_row+1:end, mid_col+1:end); % Bottom-right

quadrants = {quadrant1, quadrant2, quadrant3, quadrant4};
frequencies = [7, 6, 5, 4]; % lp/mm for each quadrant (7, 6, 5, 4)

% Preallocate results structure
results = struct('quadrant', {}, 'frequency', {}, 'mean_mtf', {}, ...
                 'profile', {}, 'peaks_max', {}, 'peaks_min', {});

% 3. Process each quadrant
for q = 1:4
    fprintf('\n--- Processing Quadrant %d (%d lp/mm) ---\n', q, frequencies(q));
    
    % Get current quadrant
    current_quadrant = quadrants{q};
    [q_rows, q_cols] = size(current_quadrant);
    
    % Extract profile perpendicular to lines 
    center_row = floor(q_rows/2);
    profile = current_quadrant(center_row, :);
    
    % Add light smoothing to reduce noise
    window_size = 3;
    profile_smooth = smooth(profile, window_size);
    
    % Find peaks (Pmax) and valleys (Pmin) for each line pair
    [peaks_max, locs_max] = findpeaks(profile_smooth, 'MinPeakProminence', 5);
    [peaks_min, locs_min] = findpeaks(-profile_smooth, 'MinPeakProminence', 5);
    peaks_min = -peaks_min; % Convert back to original values
    
    % For each line pair, we need one max and one min
    % Pair peaks and valleys
    if ~isempty(locs_max) && ~isempty(locs_min)
        % Pair them in order - the first peak with the first valley
        num_pairs = min(length(peaks_max), length(peaks_min));
        mtf_values = zeros(1, num_pairs); % Preallocate
        for p = 1:num_pairs
            mtf_val = (peaks_max(p) - peaks_min(p)) / (peaks_max(p) + peaks_min(p));
            mtf_values(p) = mtf_val;
        end
    else
        mtf_values = [];
    end
    
    % Calculate mean MTF value for this quadrant
    if ~isempty(mtf_values)
        mean_mtf = mean(mtf_values);
        fprintf('Found %d line pairs\n', length(mtf_values));
        fprintf('Mean MTF value: %.4f\n', mean_mtf);
    else
        mean_mtf = NaN;
        fprintf('No line pairs detected\n');
    end
    
    % Store results 
    results(q).quadrant = q;
    results(q).frequency = frequencies(q);
    results(q).mean_mtf = mean_mtf;
    results(q).profile = profile_smooth;
    results(q).peaks_max = peaks_max;
    results(q).peaks_min = peaks_min;
    
    % 4. Plot profile for this quadrant 
    figure;
    plot(profile_smooth, 'b-', 'LineWidth', 1.5);
    hold on;
    
    % Mark the peaks and valleys found
    if ~isempty(locs_max)
        plot(locs_max, peaks_max, 'r^', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    end
    if ~isempty(locs_min)
        plot(locs_min, peaks_min, 'gv', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
    end
    
    xlabel('Pixel Position');
    ylabel('Intensity');
    title(sprintf('Quadrant %d Profile (%d lp/mm) - Mean MTF: %.3f', q, frequencies(q), mean_mtf));
    legend('Profile', 'Pmax', 'Pmin', 'Location', 'best');
    grid on;
    
    % Save figure 
    warning('off', 'MATLAB:print:FigureToolBar');
    saveas(gcf, sprintf('quadrant_%d_profile.png', q));
    warning('on', 'MATLAB:print:FigureToolBar');
end

% 5. Display all results in a table
fprintf('\n\n=== SUMMARY OF RESULTS ===\n');
fprintf('Quadrant | Frequency (lp/mm) | Mean MTF\n');
fprintf('---------|-------------------|----------\n');
for q = 1:4
    fprintf('   %d     |        %d         |  %.4f\n', q, results(q).frequency, results(q).mean_mtf);
end

% 6. Display the original image with quadrant divisions
figure;
imshow(uint8(phantom_img));
hold on;
% Draw quadrant divisions
plot([mid_col, mid_col], [1, rows], 'r-', 'LineWidth', 2);
plot([1, cols], [mid_row, mid_row], 'r-', 'LineWidth', 2);
title('Original Quadrant Phantom Image with Divisions');

% Save final figure 
warning('off', 'MATLAB:print:FigureToolBar');
saveas(gcf, 'phantom_with_quadrants.png');
warning('on', 'MATLAB:print:FigureToolBar');