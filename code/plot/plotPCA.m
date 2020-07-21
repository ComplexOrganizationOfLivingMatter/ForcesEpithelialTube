%% Analysis of forces

clear all
%close all

typeOfData = 'untilSR4_AdhesionA0FromWTGlands';
tissue = 'SalivaryGlandWT'; % 'Frusta', 'Voronoi' or 'SalivaryGlandWT'

load(['..\..\results\' typeData '_20_07_2020.mat'])

colourBand = [0 1 0; 0 0 1; 0.5 0.5 0.5];
numSR = 7;

tablePerSR = vertcat(infoPerSurfaceRatio_Voronoi{numSR}, infoPerSurfaceRatio_Frusta{numSR}, infoPerSurfaceRatio_SGland{numSR});

[coeff, score, latent, tsquared, explained, mu] = pca([tablePerSR.Area tablePerSR.Perimeter tablePerSR.adhesionEnergy tablePerSR.elasticEnergy tablePerSR.contractilityEnergy]);

figure; 
for numRow = 1:size(score, 1)
    if contains(tablePerSR{numRow, 1}{:}, 'Gland')
        plot(score(numRow, 1), score(numRow, 2), 'x', 'MarkerEdgeColor', colourBand(1, :));
    elseif contains(tablePerSR{numRow, 1}{:}, 'oronoi')
        plot(score(numRow, 1), score(numRow, 2), 'x', 'MarkerEdgeColor', colourBand(2, :));
    elseif contains(tablePerSR{numRow, 1}{:}, 'rusta')
        plot(score(numRow, 1), score(numRow, 2), 'x', 'MarkerEdgeColor', colourBand(3, :));
    end
    hold on;
end

% initPath = '../data/DataForces/';
% if isequal(tissue, 'SalivaryGlandWT') == 0
%     fullDir = [initPath tissue '/' typeOfData '/*.mat'];
% else
%     theoreticalSR = 1:2.5/6:4;
%     fullDir = [initPath tissue '/*.mat'];
% end
% 
% fileList = dir(fullDir);
% 
% tableAllEnergies = table();
% for numFileList = 1:length(fileList)
%     load([fileList(numFileList).folder '/' fileList(numFileList).name]);
%     fileNameCol = repmat({fileList(numFileList).name}, size(tableEnergies, 1), 1);
%     SRs = unique(tableEnergies.SR);
%     for numSR = 1:length(SRs)
%         tableEnergies{tableEnergies.SR == SRs(numSR), 1} = theoreticalSR(numSR);
%     end
%     tableAllEnergies = vertcat(tableAllEnergies, horzcat(cell2table(fileNameCol), tableEnergies));
% end
% 
% uniqueSurfaceRatios = unique(tableAllEnergies.SR);
% 
% for numSr = 1:length(uniqueSurfaceRatios)
%     sr = uniqueSurfaceRatios(numSr);
%     currentSRForces = tableAllEnergies(tableAllEnergies.SR == sr, :);
%     infoPerSurfaceRatio{numSr} = currentSRForces;
%     resultsPerSR(numSr, :) = [mean(currentSRForces.Area) mean(currentSRForces.Perimeter), ...
%         mean(currentSRForces.adhesionEnergy) mean(currentSRForces.elasticEnergy), ...
%         mean(currentSRForces.contractilityEnergy), ...
%         std(currentSRForces.Area) std(currentSRForces.Perimeter), ...
%         std(currentSRForces.adhesionEnergy) std(currentSRForces.elasticEnergy), ...
%         std(currentSRForces.contractilityEnergy)];
% end
