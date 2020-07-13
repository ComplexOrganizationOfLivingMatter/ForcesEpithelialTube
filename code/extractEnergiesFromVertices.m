function extractEnergiesFromVertices(typeName,tableContractility,l_c,adhesion,path2load,path2save)
delete(gcp('nocreate'))

SR = tableContractility.SR;
maxIdSRSalGlandWT = 7;%Get SR until 4
columnsNames=l_c.Properties.VariableNames;
filesToChoose=cellfun(@(x) str2double(strrep(x,typeName,'')), columnsNames);
files =  dir([path2load '*xls']);


parpool(5)
parfor nFile = 1:size(files,1)
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
        if strcmp(typeName,'SalGlandWT')        
            auxTableFiltered = auxTable;
            SRaux = unique(auxTable.Radius);
            SRfinal = SRaux(1:maxIdSRSalGlandWT);%Get SR until 4
        else
            auxTableFiltered = auxTable(ismember(round(auxTable.Radius,3),round(SR,3)),:);
            SRfinal = SR;
        end
        %get corresponding adhesion, contractility and lc
        idSimulation = ismember(filesToChoose,str2double(splName{1}));
        adhesionFile = table2array(adhesion(1,find(idSimulation)));
        l_cFile = table2array(l_c(1,find(idSimulation)));
        contractilityFile = table2array(tableContractility(:,logical([0 idSimulation])));
        
        %create dir to save
        if ~exist(path2save,'dir')
           mkdir(path2save) 
        end
        
        filePath2save = [path2save typeName splName{1} '_forces'];
        
        %calculate table and excel with energies
        if ~exist([filePath2save '.mat'],'file')
           calculateEnergiesFile(auxTableFiltered,adhesionFile,l_cFile,contractilityFile,SRfinal,filePath2save);
        end

    end
end


end