function [meanAdhesion,meanContractility,meanElasticity,stdAdhesion,stdContractility,stdElasticity,uniqSR] = getAverageForceEnergies(path2Load)

    files =  dir([path2Load '*mat']);    

    
    load([files(1).folder '\' files(1).name],'tableEnergies');
    adhesions = zeros(size(files,1),length(unique(tableEnergies.SR)));
    contractility = zeros(size(files,1),length(unique(tableEnergies.SR)));
    elasticity = zeros(size(files,1),length(unique(tableEnergies.SR)));
    for nFile = 1:size(files,1)
        load([files(nFile).folder '\' files(nFile).name],'tableEnergies');
        uniqSR = unique(tableEnergies.SR);
        for nSR = 1:length(uniqSR)
           idSR = tableEnergies.SR == uniqSR(nSR); 
           adhesions(nFile,nSR) = mean(tableEnergies.adhesionEnergy(idSR));
           contractility(nFile,nSR) = mean(tableEnergies.contractilityEnergy(idSR));
           elasticity(nFile,nSR) = mean(tableEnergies.elasticEnergy(idSR)); 
        end
    end
    meanAdhesion = mean(adhesions);
    meanContractility = mean(contractility);
    meanElasticity = mean(elasticity);
    stdAdhesion = std(adhesions);
    stdContractility = std(contractility);
    stdElasticity = std(elasticity);

end