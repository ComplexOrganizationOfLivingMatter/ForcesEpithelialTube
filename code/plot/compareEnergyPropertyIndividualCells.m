function compareEnergyPropertyIndividualCells(cellTablesVoronoi,cellTablesFrusta,numSR,colour, path2save)

    mkdir(path2save)

    %% plot SR vs contractility energy
    catTablesVor = vertcat(cellTablesVoronoi{:});
    catTablesFrusta = vertcat(cellTablesFrusta{:});
    maxContractibility = max(max(catTablesFrusta.contractilityEnergy),max(catTablesVor.contractilityEnergy));
    
    h = figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');   

    %Voronoi
    for i = 1:size(cellTablesVoronoi,1)
        subplot(1,size(cellTablesVoronoi,1),i);
        plot(cellTablesVoronoi{i}.SR,cellTablesVoronoi{i}.contractilityEnergy,'LineWidth',2,'Color',colour(2,:))
        hold on
        for j = 1:numSR-1
            text(cellTablesVoronoi{i}.SR(j)+0.25,cellTablesVoronoi{i}.contractilityEnergy(j),num2str(cellTablesVoronoi{i}.numberOfApicoBasalTransitionsNext(j))) 
        end
        hold on
    end
    
    %Frusta
    for i = 1:size(cellTablesFrusta,1)
        nameFrusta = cellTablesFrusta{i}.fileNameCol{1};
        nameFrusta = strrep(nameFrusta,'Frusta','');
        nameFrusta = strrep(nameFrusta,'_forces.mat','');
        subplot(1,size(cellTablesFrusta,1),i);
        plot(cellTablesFrusta{i}.SR,cellTablesFrusta{i}.contractilityEnergy,'LineWidth',2,'Color',colour(3,:))
        title(['Realization ' nameFrusta ' - Cell ' num2str(cellTablesFrusta{i}.cellID(1))] )
        xlabel('SR')
        ylabel('Contractility energy')
        ylim([0 maxContractibility+maxContractibility/10])
        set(gca,'FontSize', 12,'FontName','Helvetica','YGrid','on','TickDir','out','Box','off');

        hold on
    end
    legend({'Voronoi','Frusta'})
    hold off

    savefig(h,[path2save 'Contractibility_' date])
    print(h,[path2save 'Contractibility_' date],'-dtiff','-r300')
    

    %% plot adhesion energy
    maxAdhesion = max(max(catTablesFrusta.adhesionEnergy),max(catTablesVor.adhesionEnergy));
    minAdhesion = min(min(catTablesFrusta.adhesionEnergy),min(catTablesVor.adhesionEnergy));

    h = figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');   
    %Voronoi
    for i = 1:size(cellTablesVoronoi,1)
        subplot(1,size(cellTablesVoronoi,1),i);
        plot(cellTablesVoronoi{i}.SR,cellTablesVoronoi{i}.adhesionEnergy,'LineWidth',2,'Color',colour(2,:))
        hold on
    end
    
    %Frusta
    for i = 1:size(cellTablesFrusta,1)
        nameFrusta = cellTablesFrusta{i}.fileNameCol{1};
        nameFrusta = strrep(nameFrusta,'Frusta','');
        nameFrusta = strrep(nameFrusta,'_forces.mat','');
        subplot(1,size(cellTablesFrusta,1),i);
        plot(cellTablesFrusta{i}.SR,cellTablesFrusta{i}.adhesionEnergy,'LineWidth',2,'Color',colour(3,:))
        title(['Realization ' nameFrusta ' - Cell ' num2str(cellTablesFrusta{i}.cellID(1))] )
        xlabel('SR')
        ylabel('Adhesion energy')
        ylim([minAdhesion maxAdhesion])
        set(gca,'FontSize', 12,'FontName','Helvetica','YGrid','on','TickDir','out','Box','off');

        hold on
    end
    legend({'Voronoi','Frusta'})    
    hold off
    
    savefig(h,[path2save 'Adhesion_' date])
    print(h,[path2save 'Adhesion_' date],'-dtiff','-r300')
    
    
    %% plot elasticity energy
    maxElastic = max(max(catTablesFrusta.elasticEnergy),max(catTablesVor.elasticEnergy));
    
    h = figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');   
    %Voronoi
    for i = 1:size(cellTablesVoronoi,1)
        subplot(1,size(cellTablesVoronoi,1),i);
        plot(cellTablesVoronoi{i}.SR,cellTablesVoronoi{i}.elasticEnergy,'LineWidth',2,'Color',colour(2,:))

        hold on
    end
    
    %Frusta
    for i = 1:size(cellTablesFrusta,1)
        nameFrusta = cellTablesFrusta{i}.fileNameCol{1};
        nameFrusta = strrep(nameFrusta,'Frusta','');
        nameFrusta = strrep(nameFrusta,'_forces.mat','');
        subplot(1,size(cellTablesFrusta,1),i);
        plot(cellTablesFrusta{i}.SR,cellTablesFrusta{i}.elasticEnergy,'LineWidth',2,'Color',colour(3,:))
        title(['Realization ' nameFrusta ' - Cell ' num2str(cellTablesFrusta{i}.cellID(1))] )
        xlabel('SR')
        ylabel('Elastic energy')
        ylim([0 maxElastic+maxElastic/10])
        set(gca,'FontSize', 12,'FontName','Helvetica','YGrid','on','TickDir','out','Box','off');

        hold on
    end
    legend({'Voronoi','Frusta'})  
    
    savefig(h,[path2save 'Elasticity_' date])
    print(h,[path2save 'Elasticity_' date],'-dtiff','-r300')
    
    
    
    %% plot how evolve the cells along the SR
    h = figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');   
    %Voronoi
    counter=1;
    for j = 1:numSR
        for i = 1:size(cellTablesVoronoi,1)
            nameVoronoi = cellTablesVoronoi{i}.fileNameCol{1};
            nameVoronoi = strrep(nameVoronoi,'Voronoi','');
            nameVoronoi = strrep(nameVoronoi,'_forces.mat','');
            subplot(numSR,size(cellTablesVoronoi,1),counter);
            vertices = cellTablesVoronoi{i}.vertexesXY;
            verticesSR = vertices{j};
            plot([verticesSR(1:2:end) verticesSR(1)],[verticesSR(2:2:end) verticesSR(2)],'LineWidth',2,'Color',colour(2,:))
     
            if j==1
                title(['Realization ' nameVoronoi ' - Cell ' num2str(cellTablesVoronoi{i}.cellID(1))] )
            end
            axis equal
            hold on
            counter=counter+1;
        end
    end
    
    counter=1;
    for j = 1:numSR
        for i = 1:size(cellTablesFrusta,1)
            subplot(numSR,size(cellTablesFrusta,1),counter);
            vertices = cellTablesFrusta{i}.vertexesXY;
            verticesSR = vertices{j};
            plot([verticesSR(1:2:end) verticesSR(1)],[verticesSR(2:2:end) verticesSR(2)],'LineWidth',2,'Color',colour(3,:))
            axis equal

            hold on
            counter=counter+1;
        end
    end
    
    savefig(h,[path2save 'CellShapes_' date])
    print(h,[path2save 'CellShapes_' date],'-dtiff','-r300')
    
    
    %% Polar histogram adhesion energy
    angleCorrection = 0;
    radLim = [-90,90];
    gridAlpha = 0.1;
    lineWidth = 1;
    fontSize = 12;
    dotSize = 6;
    fontName = 'Helvetica-Narrow';
    polarGraphic = 'polarplot';
    
    
    dir2save = [path2save 'PolarDistribution_AdhesionEnergy_' date];
    param1 = 'edgesLength';
    param2 = 'edgesAngle';
    plotPolarGraphic(cellTablesVoronoi, cellTablesFrusta,param1,param2,polarGraphic,numSR,colour(2,:),colour(3,:),dotSize,angleCorrection,radLim,gridAlpha,lineWidth,fontSize,fontName,dir2save)      
    
    
    

end