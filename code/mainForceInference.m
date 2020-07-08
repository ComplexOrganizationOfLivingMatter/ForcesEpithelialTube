clear all

SRmax = 4; % SR 4 or 1.75
copyAdhesionA0FromGlands = 0; %true or false
setOfParams={[4,0],[4,1],[1.75,0],[1.75,1]};
path2load = '..\data\';

for i=3:length(setOfParams)
    params = setOfParams{i};
    SRmax = params(1);
    copyAdhesionA0FromGlands = params(2);
    [filePath, path2saveVoronoi,path2saveFrusta,path2loadVoronoi, path2loadFrusta] = chooseVoronoiFrustaPath(SRmax,copyAdhesionA0FromGlands,path2load);
    path2saveSalGlandWT = [path2load 'DataForces\SalivaryGlandWT\'];
    path2loadSalGlandWT = [path2load 'RawExcelsWithVertices\SalGlandWT\'];

    load(filePath,'tableContractilitySalGlandWT','tableContractilityVoronoi','tableContractilityFrusta','adhesionSalGland_WT','adhesionVoronoi','adhesionFrusta','l_cSalGlandWT','l_cVoronoi','l_cFrusta');

    %% Extract energy from vertices
    %%Simulations (Voronoi and Frusta)
    extractEnergiesFromVertices('Voronoi',tableContractilityVoronoi,l_cVoronoi,adhesionVoronoi,path2loadVoronoi,path2saveVoronoi)
    extractEnergiesFromVertices('Frusta',tableContractilityFrusta,l_cFrusta,adhesionFrusta,path2loadFrusta,path2saveFrusta)
    extractEnergiesFromVertices('SalGlandWT',tableContractilitySalGlandWT,l_cSalGlandWT,adhesionSalGland_WT,path2loadSalGlandWT,path2saveSalGlandWT)
end