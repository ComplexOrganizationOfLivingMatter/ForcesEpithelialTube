function [tableAllEnergies,infoPerSurfaceRatio,resultsPerSR] = summarizingOfForcesData(path2load,srMax)
    
    infoPerSurfaceRatio=[];
    resultsPerSR =[];
    if srMax==4
        theoreticalSR = 1:0.5:4;
    end

    %% Summarize info
    fileList = dir([path2load '/*.mat']);

    tableAllEnergies = table();
    for numFileList = 1:length(fileList)
        load([fileList(numFileList).folder '/' fileList(numFileList).name]);
        fileNameCol = repmat({fileList(numFileList).name}, size(tableEnergies, 1), 1);
        SRs = unique(tableEnergies.SR);
        for numSR = 1:length(SRs)
            tableEnergies{tableEnergies.SR == SRs(numSR), 1} = theoreticalSR(numSR);
        end
        tableAllEnergies = vertcat(tableAllEnergies, horzcat(cell2table(fileNameCol), tableEnergies));
    end

%     uniqueSurfaceRatios = unique(tableAllEnergies.SR);
% 
%     for numSr = 1:length(uniqueSurfaceRatios)
%         sr = uniqueSurfaceRatios(numSr);
%         currentSRForces = tableAllEnergies(tableAllEnergies.SR == sr, :);
%         infoPerSurfaceRatio{numSr} = currentSRForces;
%         resultsPerSR(numSr, :) = [mean(currentSRForces.Area) mean(currentSRForces.Perimeter), ...
%             mean(currentSRForces.adhesionEnergy) mean(currentSRForces.elasticEnergy), ...
%             mean(currentSRForces.contractilityEnergy), ...
%             std(currentSRForces.Area) std(currentSRForces.Perimeter), ...
%             std(currentSRForces.adhesionEnergy) std(currentSRForces.elasticEnergy), ...
%             std(currentSRForces.contractilityEnergy)];
%     end

end

