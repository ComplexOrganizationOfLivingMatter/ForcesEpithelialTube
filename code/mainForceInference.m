clear all
delete(gcp('nocreate'))

SRmax = 4; % SR 4 or 1.75
copyAdhesionA0FromGlands = 0; %true or false

path2load = '..\data\';
if SRmax==4 && copyAdhesionA0FromGlands==0
   filePath = [path2load 'linearProgramingParameter_untilSR4_07-Jul-2020.mat'];
   path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR4\'];
   path2saveFrusta = [path2load 'DataForces\Frusta\untilSR4\'];
end
if SRmax==4 && copyAdhesionA0FromGlands==1
   filePath = [path2load 'linearProgramingParameter_untilSR4_SalGlandWT_adhesion_A0_07-Jul-2020.mat'];
   path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR4_AdhesionA0FromWTGlands\'];
   path2saveFrusta = [path2load 'DataForces\Frusta\untilSR4_AdhesionA0FromWTGlands\'];
end
if SRmax==1.75 && copyAdhesionA0FromGlands==0
    filePath = [path2load 'linearProgramingParameter_untilSR175_07-Jul-2020.mat'];
    path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR175\'];
    path2saveFrusta = [path2load 'DataForces\Frusta\untilSR175\'];
end
if SRmax==1.75 && copyAdhesionA0FromGlands==1
    filePath = [path2load 'linearProgramingParameter_untilSR175_SalGlandWT_adhesion_A0_07-Jul-2020.mat'];
    path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR175_AdhesionA0FromWTGlands\'];
    path2saveFrusta = [path2load 'DataForces\Frusta\untilSR175_AdhesionA0FromWTGlands\'];
end
path2saveSalGlandWT = [path2load 'DataForces\SalivaryGlandWT\'];
load(filePath,'tableContractilitySalGlandWT','tableContractilityVoronoi','tableContractilityFrusta','adhesionSalGland_WT','adhesionVoronoi','adhesionFrusta','l_cSalGlandWT','l_cVoronoi','l_cFrusta');

%% Voronoi
SR = tableContractilityVoronoi.SR;

voronoiColumnsNames=l_cVoronoi.Properties.VariableNames;
voronoiFilesToChoose=cellfun(@(x) str2double(strrep(x,'Voronoi','')), voronoiColumnsNames);
files = dir([path2load 'RawExcelsWithVertices\Voronoi\SR5\*xls']);

parpool(5)
parfor nFile = 1:size(files,1)
    splName = strsplit(files(nFile).name,'realization');
    splName = strsplit(splName{2},'_');
    if(any(ismember(str2double(splName{1}),voronoiFilesToChoose)))
        files(nFile).name
        auxTable = readtable([files(nFile).folder '\' files(nFile).name]);
        %Filter by SR
        auxTableFiltered = auxTable(ismember(auxTable.Radius,SR),:);
        %get corresponding adhesion, contractility and lc
        idVoronoi = ismember(voronoiFilesToChoose,str2double(splName{1}));
        adhesionVoronoiFile = table2array(adhesionVoronoi(1,find(idVoronoi)));
        l_cVoronoiFile = table2array(l_cVoronoi(1,find(idVoronoi)));
        contractilityVoronoiFile = table2array(tableContractilityVoronoi(:,idVoronoi));
        
        %create dir to save
        if ~exist(path2saveVoronoi,'dir')
           mkdir(path2saveVoronoi) 
        end
        
        filePath2save = [path2saveVoronoi 'Voronoi' splName{1} '_forces'];
        
        %calculate table and excel with energies
        calculateEnergiesFile(auxTableFiltered,adhesionVoronoiFile,l_cVoronoiFile,contractilityVoronoiFile,SR,filePath2save);

    end
end