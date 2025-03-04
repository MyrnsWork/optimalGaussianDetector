% Maël Laviec
% mlaviec@enseirb-matmeca.fr
% ENSEIRB-MATMECA
% Juin, 2022

function fig = displayLogLRT( logLRT_lin,...
                              gammaLogLRT_dB,...
                              Ncd,...
                              iFigure           )

    fig = figure( iFigure );
    plot( 10*log10( abs( logLRT_lin(1,:) ) ), 'LineWidth', 1.5 ), hold on;
    plot( gammaLogLRT_dB * ones(1, Ncd), 'LineWidth', 1.5 ), hold off;
    legend( "LogLRT", "Seuil Optimal" )
    ylabel('Rapport du log-vraisemblance [dB]')
    xlabel('Case distance')
    xlim([1 Inf])
    title('Evolution du rapport de log-vraisemblance en fonction de la distance [dB]')
    set(fig, 'Units', 'Normalized', 'Position', [0 0 1 1]);


end      


