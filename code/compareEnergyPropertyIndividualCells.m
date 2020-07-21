function compareEnergyPropertyIndividualCells(cellTablesVoronoi,cellTablesFrusta,numSR,colour, path2save)

    mkdir(path2save)

    %% plot contractility energy
    catTablesVor = vertcat(cellTablesVoronoi{:});
    catTablesFrusta = vertcat(cellTablesFrusta{:});
    maxContractibility = max(max(catTablesFrusta.contractilityEnergy),max(catTablesVor.contractilityEnergy));
    
    h = figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');   

    %Voronoi
    for i = 1:size(cellTablesVoronoi,1)
        subplot(1,size(cellTablesVoronoi,1),i);
        plot(cellTablesVoronoi{i}.SR,cellTablesVoronoi{i}.contractilityEnergy,'LineWidth',2,'Color',colour(2,:))
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
    
%
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
    
    
    %plot polar histograms along SR
    
    %% plot how evolve the cells along the SR
    h = figure;
    %Voronoi
    minXCoordPerCell = zeros(1,5);
    minYCoordPerCell =zeros(1,5);
    maxXCoordPerCell = zeros(1,5);
    maxYCoordPerCell =zeros(1,5);
    for nCel = 1:size(cellTablesVoronoi,1)
        verVor= cellTablesVoronoi{nCel}.vertexesXY;
        verFrusta= cellTablesFrusta{nCel}.vertexesXY;
        verCell=horzcat(verVor{:},verFrusta{:});
        minXCoordPerCell(nCel) = min(verCell(1:2:end));
        minYCoordPerCell(nCel) = min(verCell(2:2:end));
        maxXCoordPerCell(nCel) = max(verCell(1:2:end));
        maxYCoordPerCell(nCel) = max(verCell(2:2:end));
    end
     
    counter=1;
    for j = 1:numSR
        for i = 1:size(cellTablesVoronoi,1)
            nameVoronoi = cellTablesVoronoi{i}.fileNameCol{1};
            nameVoronoi = strrep(nameVoronoi,'Voronoi','');
            nameVoronoi = strrep(nameVoronoi,'_forces.mat','');
            subplot(numSR,size(cellTablesVoronoi,1)*2,counter);
            vertices = cellTablesVoronoi{i}.vertexesXY;
            verticesSR = vertices{j};
            plot([verticesSR(1:2:end) verticesSR(1)],[verticesSR(2:2:end) verticesSR(2)],'LineWidth',2,'Color',colour(2,:))
            xlim([minXCoordPerCell(i) maxXCoordPerCell(i)])
            ylim([minYCoordPerCell(i) maxYCoordPerCell(i)])
            if j==1
                title(['Voronoi ' nameVoronoi ' - Cell ' num2str(cellTablesVoronoi{i}.cellID(1))] )
            end
            hold on
            counter=counter+2;
        end
    end
    
    counter=2;
    for j = 1:numSR
        for i = 1:size(cellTablesFrusta,1)
            nameFrusta = cellTablesFrusta{i}.fileNameCol{1};
            nameFrusta = strrep(nameFrusta,'Frusta','');
            nameFrusta = strrep(nameFrusta,'_forces.mat','');
            subplot(numSR,size(cellTablesFrusta,1)*2,counter);
            vertices = cellTablesFrusta{i}.vertexesXY;
            verticesSR = vertices{j};
            plot([verticesSR(1:2:end) verticesSR(1)],[verticesSR(2:2:end) verticesSR(2)],'LineWidth',2,'Color',colour(3,:))
            xlim([minXCoordPerCell(i) maxXCoordPerCell(i)])
            ylim([minYCoordPerCell(i) maxYCoordPerCell(i)])

            hold on
            counter=counter+2;
        end
    end
    
    savefig(h,[path2save 'CellShapes_' date])
    print(h,[path2save 'CellShapes_' date],'-dtiff','-r300')
    
    
    %% Polar histogram adhesion energy
    h = figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');   

    %Voronoi
        
    counter=1;
    for j = 1:numSR
        for i = 1:size(cellTablesVoronoi,1)
            nameVoronoi = cellTablesVoronoi{i}.fileNameCol{1};
            nameVoronoi = strrep(nameVoronoi,'Voronoi','');
            nameVoronoi = strrep(nameVoronoi,'_forces.mat','');
            subplot(numSR,size(cellTablesVoronoi,1)*2,counter);
            edgesLength = cellTablesVoronoi{i}.edgesLength;
            edgesAngle = cellTablesVoronoi{i}.edgesAngle{j};
            lambda = cellTablesVoronoi{i}.Lambda;
            edgesAdhesionEnergy = edgesLength{j}.*lambda(j);
            

            for nEdges = 1:length(edgesAngle)
                polarplot([0 edgesAngle(nEdges)],[0 abs(edgesAdhesionEnergy(nEdges))],'LineWidth',2,'Color',colour(2,:))
                hold on
            end
            if j==1
                title(['Voronoi ' nameVoronoi ' - Cell ' num2str(cellTablesVoronoi{i}.cellID(1))] )
            end
            hold on
            counter=counter+2;
        end
    end
    
    counter=2;
    for j = 1:numSR
        for i = 1:size(cellTablesFrusta,1)
            nameFrusta = cellTablesFrusta{i}.fileNameCol{1};
            nameFrusta = strrep(nameFrusta,'Frusta','');
            nameFrusta = strrep(nameFrusta,'_forces.mat','');
            subplot(numSR,size(cellTablesFrusta,1)*2,counter);
            edgesLength = cellTablesFrusta{i}.edgesLength;
            edgesAngle = cellTablesFrusta{i}.edgesAngle{j};
            lambda = cellTablesFrusta{i}.Lambda;
            edgesAdhesionEnergy = edgesLength{j}.*lambda(j);
            
            for nEdges = 1:length(edgesAngle)
                polarplot([0 edgesAngle(nEdges)],[0 abs(edgesAdhesionEnergy(nEdges))],'LineWidth',2,'Color',colour(3,:))
                hold on
            end
            
            hold on
            counter=counter+2;
        end
    end
    
    savefig(h,[path2save 'PolarDistribution_AdhesionEnergy_' date])
    print(h,[path2save 'PolarDistribution_AdhesionEnergy_' date],'-dtiff','-r300')
    

end