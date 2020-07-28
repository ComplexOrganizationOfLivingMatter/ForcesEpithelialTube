%% Analysis of forces

clear all
%close all

typeOfData = 'untilSR4_AdhesionA0FromWTGlands';
tissue = 'SalivaryGlandWT'; % 'Frusta', 'Voronoi' or 'SalivaryGlandWT'

%load(['..\..\results\' typeData '_28_07_2020.mat'])

colourBand = [0 1 0; 0 0 1; 0.5 0.5 0.5];
numSR = 7;

% tablePerSR = vertcat(infoPerSurfaceRatio_Voronoi{numSR}, infoPerSurfaceRatio_Frusta{numSR}, infoPerSurfaceRatio_SGland{numSR});
% 
% [coeff, score, latent, tsquared, explained, mu] = pca([tablePerSR.Area tablePerSR.Perimeter tablePerSR.adhesionEnergy tablePerSR.elasticEnergy tablePerSR.contractilityEnergy]);
% 
% figure; 
% for numRow = 1:size(score, 1)
%     if contains(tablePerSR{numRow, 1}{:}, 'Gland')
%         plot(score(numRow, 1), score(numRow, 2), 'x', 'MarkerEdgeColor', colourBand(1, :));
%     elseif contains(tablePerSR{numRow, 1}{:}, 'oronoi')
%         plot(score(numRow, 1), score(numRow, 2), 'x', 'MarkerEdgeColor', colourBand(2, :));
%     elseif contains(tablePerSR{numRow, 1}{:}, 'rusta')
%         plot(score(numRow, 1), score(numRow, 2), 'x', 'MarkerEdgeColor', colourBand(3, :));
%     end
%     hold on;
% end

