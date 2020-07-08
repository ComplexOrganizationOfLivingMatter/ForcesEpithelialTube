function extractEnergiesFromVertices(typeName,tableContractility,l_c,adhesion,path2load,path2save)

SR = tableContractility.SR;
columnsNames=l_c.Properties.VariableNames;
filesToChoose=cellfun(@(x) str2double(strrep(x,typeName,'')), columnsNames);

if strcmp(typeName,'Voronoi') || strcmp(typeName,'Frusta') 
    files = dir([path2load 'RawExcelsWithVertices\' typeName '\SR5\*xls']);
else
    files =  dir([path2load 'RawExcelsWithVertices\' typeName '\*xls']);
end

delete(gcp('nocreate'))

for nFile = 1:size(files,1)
    if strcmp(typeName,'Voronoi') || strcmp(typeName,'Frusta')        
        splName = strsplit(files(nFile).name,'realization');
        splName = strsplit(splName{2},'_');
    end
    if strcmp(typeName,'SalGlandWT')        
        splName = strsplit(files(nFile).name,'salivary');
        splName = strsplit(splName{2},'.xls');
    end
        
    if(any(ismember(str2double(splName{1}),filesToChoose)))
        files(nFile).name
        auxTable = readtable([files(nFile).folder '\' files(nFile).name]);
        %Filter by SR
        auxTableFiltered = auxTable(ismember(auxTable.Radius,SR),:);
        %get corresponding adhesion, contractility and lc
        idSimulation = ismember(filesToChoose,str2double(splName{1}));
        adhesionFile = table2array(adhesion(1,find(idSimulation)));
        l_cFile = table2array(l_c(1,find(idSimulation)));
        contractilityFile = table2array(tableContractility(:,idSimulation));
        
        %create dir to save
        if ~exist(path2save,'dir')
           mkdir(path2save) 
        end
        
        filePath2save = [path2save typeName splName{1} '_forces'];
        
        %calculate table and excel with energies
        if ~exist([filePath2save '.mat'],'file')
           calculateEnergiesFile(auxTableFiltered,adhesionFile,l_cFile,contractilityFile,SR,filePath2save);
        end

    end
end


end