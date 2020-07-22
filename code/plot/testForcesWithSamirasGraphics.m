clear all

SRmax = 4; % SR 4 or 1.75
copyAdhesionA0FromGlands = 0; %true or false
setOfParams={[4,0],[4,1],[1.75,0],[1.75,1]};
path2load = '..\data\';

for i=2:length(setOfParams)
    params = setOfParams{i};
    SRmax = params(1);
    copyAdhesionA0FromGlands = params(2);
    [~, path2LoadVoronoi,path2LoadFrusta,~, ~] = chooseVoronoiFrustaPath(SRmax,copyAdhesionA0FromGlands,path2load);
    path2LoadSalGlandWT = [path2load 'DataForces\SalivaryGlandWT\'];
    
    [meanVorAdhesion,meanVorContractility,meanVorElasticity,stdVorAdhesion,stdVorContractility,stdVorElasticity,SRVor] = getAverageForceEnergies(path2LoadVoronoi);
    [meanFrustaAdhesion,meanFrustaContractility,meanFrustaElasticity,stdFrustaAdhesion,stdFrustaContractility,stdFrustaElasticity,SRFrusta] = getAverageForceEnergies(path2LoadFrusta);
    [meanSalGlandAdhesion,meanSalGlandContractility,meanSalGlandElasticity,stdSalGlandAdhesion,stdSalGlandContractility,stdSalGlandElasticity,SRSalGland] = getAverageForceEnergies(path2LoadSalGlandWT);
    
    figure;
    errorbar(SRVor,meanVorAdhesion,stdVorAdhesion,'CapSize',4,'MarkerSize',4,...
            'Color',[1 0 0],'MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[1 0 0],'LineWidth',0.5)
        hold on
    errorbar(SRVor,meanVorContractility,stdVorContractility,'CapSize',4,'MarkerSize',4,...
        'Color',[0 0 1],'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1],'LineWidth',0.5)
    errorbar(SRVor,meanVorElasticity,stdVorElasticity,'CapSize',4,'MarkerSize',4,...
        'Color',[0 1 0],'MarkerEdgeColor',[0 1 0],'MarkerFaceColor',[0 1 0],'LineWidth',0.5)
    ylim([-0.1 0.3])
    hold off
    title('VoronoiForces')
    xlabel('SR')
    ylabel('Energies')
    legend({'adhesion','contractility','elasticity'})
    
    figure;
    errorbar(SRFrusta,meanFrustaAdhesion,stdFrustaAdhesion,'CapSize',4,'MarkerSize',4,...
            'Color',[1 0 0],'MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[1 0 0],'LineWidth',0.5)
        hold on
    errorbar(SRFrusta,meanFrustaContractility,stdFrustaContractility,'CapSize',4,'MarkerSize',4,...
        'Color',[0 0 1],'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1],'LineWidth',0.5)
    errorbar(SRFrusta,meanFrustaElasticity,stdFrustaElasticity,'CapSize',4,'MarkerSize',4,...
        'Color',[0 1 0],'MarkerEdgeColor',[0 1 0],'MarkerFaceColor',[0 1 0],'LineWidth',0.5)
    ylim([-0.1 0.3])
    
    hold off
    title('FrustaForces')
    xlabel('SR')
    ylabel('Energies')
    legend({'adhesion','contractility','elasticity'})
    
    figure;
    errorbar(SRSalGland,meanSalGlandAdhesion,stdSalGlandAdhesion,'CapSize',4,'MarkerSize',4,...
            'Color',[1 0 0],'MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[1 0 0],'LineWidth',0.5)
        hold on
    errorbar(SRSalGland,meanSalGlandContractility,stdSalGlandContractility,'CapSize',4,'MarkerSize',4,...
        'Color',[0 0 1],'MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 0 1],'LineWidth',0.5)
    errorbar(SRSalGland,meanSalGlandElasticity,stdSalGlandElasticity,'CapSize',4,'MarkerSize',4,...
        'Color',[0 1 0],'MarkerEdgeColor',[0 1 0],'MarkerFaceColor',[0 1 0],'LineWidth',0.5)
    ylim([-0.1 0.3])
    
    hold off
    title('SalGlandForces')
    xlabel('SR')
    ylabel('Energies')
    legend({'adhesion','contractility','elasticity'})
    
end