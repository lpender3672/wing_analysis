function plotfoil(geometry_file)
% simple function which plots the relevant airfoil geomtry from data file
%   INPUT:
%   location of the file containing airfoil geomtery

    geometry_file = ['Geometry/' geometry_file '.surf'];

    [xk yk] = textread ( geometry_file, '%f%f' );

    figure(6)
    plot(xk, yk)
    axis image
    xlim([-0.1, 1.1])
    ylim([-0.3, 0.3])
    xlabel('x/c')
    ylabel('y/c')

end