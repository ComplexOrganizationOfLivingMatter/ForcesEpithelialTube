clear all

SRmax = 4; % SR 4 or 1.75
copyAdhesionA0FromGlands = 0; %true or false

path2Load = '..\data\';
if SRmax==4 && copyAdhesionA0FromGlands==0
   filePath = [path2Load 'linearProgramingParameter_untilSR4_07-Jul-2020.mat'];
end
if SRmax==4 && copyAdhesionA0FromGlands==1
   filePath = [path2Load 'linearProgramingParameter_untilSR4_SalGlandWT_adhesion_A0_07-Jul-2020.mat'];
end
if SRmax==1.75 && copyAdhesionA0FromGlands==0
    filePath = [path2Load 'linearProgramingParameter_untilSR175_07-Jul-2020.mat'];
end
if SRmax==1.75 && copyAdhesionA0FromGlands==1
    filePath = [path2Load 'linearProgramingParameter_untilSR175_SalGlandWT_adhesion_A0_07-Jul-2020.mat'];
end
load(filePath,'tableContractilitySalGlandWT','tableContractilityVoronoi','tableContractilityFrusta','adhesionSalGland_WT','adhesionVoronoi','adhesionFrusta','l_cSalGlandWT','l_cVoronoi','l_cFrusta');

%% Voronoi
SR = tableContractilityVoronoi.SR;

voronoiColumnsNames=l_cVoronoi.Properties.VariableNames;
voronoiFilesToChoose=cellfun(@(x) str2double(strrep(x,'Voronoi','')), voronoiColumnsNames);
files = dir([path2Load 'RawExcelsWithVertices\Voronoi\SR5\*xls']);
for nFile = 1:size(files,1)
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

        calculateEnergiesFile(auxTableFiltered,adhesionVoronoiFile,l_cVoronoiFile,contractilityVoronoiFile,SR)
    end
end