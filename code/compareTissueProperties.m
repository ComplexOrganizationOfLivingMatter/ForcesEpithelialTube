function compareTissueProperties(cellTablesVoronoi,cellTablesFrusta,numSR,colour, path2save)

    mkdir(path2save)

    %% Polar scatter major axis (length - angle)
    h = figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');   

    sz=10;
    angleCorrection = 0;
    %Voronoi
    for j = 1:numSR
        cellsMajorAxLength = [];
        cellsOrientations = [];
        for i = 1:size(cellTablesVoronoi,1)
            cellMajorAxisLength = cellTablesVoronoi{i}.majorAxisLength(j);
            cellOrientation = cellTablesVoronoi{i}.cellOrientation(j)-angleCorrection;
            cellsMajorAxLength = [cellsMajorAxLength, cellMajorAxisLength];
            cellsOrientations = [cellsOrientations cellOrientation];
        end
        subplot(2,numSR,j);

        polarscatter(cellsMajorAxLength,deg2rad(cellsOrientations),sz,'filled','MarkerFaceColor',colour(2,:))

        ax=gca;
       % ax.ThetaLimMode='manual';
       % ax.ThetaLim=[-90,90];
        ax.GridAlpha=0.1;
        ax.LineWidth=1;
        ax.FontSize=12;
        ax.FontName='Helvetica-Narrow';      
        title(['SR ' num2str(cellTablesVoronoi{i}.SR(j))])
    end
    
    %Frusta
    for j = 1:numSR
        cellsMajorAxLength = [];
        cellsOrientations = [];
        for i = 1:size(cellTablesFrusta,1)
            cellMajorAxisLength = cellTablesFrusta{i}.majorAxisLength(j);
            cellOrientation = cellTablesFrusta{i}.cellOrientation(j)-angleCorrection;
            cellsMajorAxLength = [cellsMajorAxLength, cellMajorAxisLength];
            cellsOrientations = [cellsOrientations cellOrientation];
        end
        subplot(2,numSR,j+numSR);

        polarscatter(cellsMajorAxLength,deg2rad(cellsOrientations),sz,'filled','MarkerFaceColor',colour(3,:))

        ax=gca;
        %ax.ThetaLimMode='manual';
        %ax.ThetaLim=[-90,90];
        ax.GridAlpha=0.1;
        ax.LineWidth=1;
        ax.FontSize=12;
        ax.FontName='Helvetica-Narrow';      
        title(['SR ' num2str(cellTablesFrusta{i}.SR(j))])
    end
    
    savefig(h,[path2save 'PolarScatter_MajorAxis_Length_Angle_' date])
    print(h,[path2save 'PolarScatter_MajorAxis_Length_Angle_' date],'-dtiff','-r300')
    
    
    
    
    
    %% Polar scatter major/minor axis length - cell orientation
    h = figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');   

    sz=10;
    %Voronoi
    for j = 1:numSR
        cellsAxesRelation = [];
        cellsOrientations = [];
        for i = 1:size(cellTablesVoronoi,1)
            cellAxesRelation = cellTablesVoronoi{i}.axesLengthRelation(j);
           cellOrientation = cellTablesVoronoi{i}.cellOrientation(j)-angleCorrection;
            cellsAxesRelation = [cellsAxesRelation, cellAxesRelation];
            cellsOrientations = [cellsOrientations cellOrientation];
        end
        subplot(2,numSR,j);

        polarscatter(cellsAxesRelation,deg2rad(cellsOrientations),sz,'filled','MarkerFaceColor',colour(2,:))

        ax=gca;
       % ax.ThetaLimMode='manual';
       % ax.ThetaLim=[-90,90];
        ax.GridAlpha=0.1;
        ax.LineWidth=1;
        ax.FontSize=12;
        ax.FontName='Helvetica-Narrow';      
        title(['SR ' num2str(cellTablesVoronoi{i}.SR(j))])
    end
    
    %Frusta
    for j = 1:numSR
        cellsAxesRelation = [];
        cellsOrientations = [];
        for i = 1:size(cellTablesFrusta,1)
            cellAxesRelation = cellTablesFrusta{i}.axesLengthRelation(j);
            cellOrientation = cellTablesFrusta{i}.cellOrientation(j)-angleCorrection;
            cellsAxesRelation = [cellsAxesRelation, cellAxesRelation];
            cellsOrientations = [cellsOrientations cellOrientation];
        end
        subplot(2,numSR,j+numSR);

        polarscatter(cellsAxesRelation,deg2rad(cellsOrientations),sz,'filled','MarkerFaceColor',colour(3,:))

        ax=gca;
        %ax.ThetaLimMode='manual';
        %ax.ThetaLim=[-90,90];
        ax.GridAlpha=0.1;
        ax.LineWidth=1;
        ax.FontSize=12;
        ax.FontName='Helvetica-Narrow';      
        title(['SR ' num2str(cellTablesFrusta{i}.SR(j))])
    end
    
    savefig(h,[path2save 'PolarScatter_AxesRelation_CellOrientation_' date])
    print(h,[path2save 'PolarScatter_AxesRelation_CellOrientation_' date],'-dtiff','-r300')
    
end