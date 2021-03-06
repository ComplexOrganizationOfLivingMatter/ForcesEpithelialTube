clear all
close all

addpath(genpath('lib'))
addpath(genpath('plot'))

typeOfData = {'untilSR4_AdhesionA0FromWTGlands','untilSR4'};
tissues = {'SalivaryGlandWT', 'Frusta', 'Voronoi'};
colourBand = [0 1 0; 0 0 1; 0.5 0.5 0.5];
numSR = 7;
nRandomCells = 5;
path2save = '..\results\graphics\individualCellsComparisons\';
randomizationId = randi(100000,1);

for nTypeData = 1 : length(typeOfData)
    load(['..\results\' typeOfData{nTypeData} '_28-Jul-2020.mat'])
    %select random cells in frusta and Voronoi
    [randomCellTablesVoronoi, randomCellTablesFrusta] = selectRandomCellsInFrustaAdndVoronoi(nRandomCells,tableAllEnergies_Voronoi,tableAllEnergies_Frusta);

%     %track individual cells energies in frusta and Voronoi along SRs
     compareEnergyPropertyIndividualCells(randomCellTablesVoronoi,randomCellTablesFrusta,numSR,colourBand,[path2save '\fewCells\rand' num2str(randomizationId) '_' num2str(nRandomCells) '_cells\'])
    
    %get general properties of the tissue
%     compareTissueProperties(randomCellTablesVoronoi,randomCellTablesFrusta,numSR,colourBand,[path2save '\generalTissue\rand' num2str(randomizationId) '_' num2str(nRandomCells) '_cells\'])
    
    close all
end
