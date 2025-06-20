function heatMapPlot(X,N,L)
    X = flipud(rot90(reshape(X,N,N)));
    imagesc(linspace(0,L,N), linspace(0,L,N), X);
    xlabel('x [m]');
    ylabel('y [m]');
    title('Temperature Heatmap');
    colorbar;
    set(gca, 'YDir', 'normal');
    axis square
end