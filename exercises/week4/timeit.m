
clear all

global Re_L np

Reynolds_numbers = [2e6, 0.5e6];
npanels = [200, 400, 600, 800];

times = zeros(length(npanels), 2 * length(Reynolds_numbers));

for i=1:length(npanels)
    np = npanels(i);
    for j=1:length(Reynolds_numbers)

        Re_L = Reynolds_numbers(j);
        tic
        timed_foil_swp();
        times(i,j) = toc;
        
    end
    
    for j=1:length(Reynolds_numbers)
        
        Re_L = Reynolds_numbers(j);
        tic
        timed_foil_swp_slow();
        times(i,j + length(npanels) - 2) = toc;
    end
end

% Create the bar chart
figure;
bar(times)

% Set the x-axis tick labels
xticklabels(string(npanels));

% Add a legend
legend('Vector Methods (Re_L = 2e6)', 'Vector Methods (Re_L = 0.5e6)', ...
       'Loop Methods (Re_L = 2e6)', 'Loop Methods (Re_L = 0.5e6)', ...
       'Location', 'northwest');

% Add labels and title
xlabel('Number of Panels');
ylabel('Execution Time (seconds)');
title('Execution Time Comparison');


