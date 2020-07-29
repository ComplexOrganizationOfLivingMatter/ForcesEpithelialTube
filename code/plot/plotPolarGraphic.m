function plotPolarGraphic(cellTablesVoronoi, cellTablesFrusta,param1,param2,polarGraphic,numSR,colour1, colour2,dotSize,angleCorrection,radLim,gridAlpha,lineWidth,fontSize,fontName,dir2save)
    h = figure('units','normalized','outerposition',[0 0 1 1],'Visible','on');   

    %Voronoi
    for j = 1:numSR
        cellsMagnitude = [];
        angles = [];
        for i = 1:size(cellTablesVoronoi,1)
            valueFieldMagnitude =  getfield(cellTablesVoronoi{i}, param1);
            valueFieldAngle =  getfield(cellTablesVoronoi{i}, param2);
            cellsMagnitude = [cellsMagnitude, valueFieldMagnitude(j)];
            angles = [angles valueFieldAngle(j)];
        end
        
        
        if strcmp(lower(polarGraphic),'polarscatter')
            subplot(2,numSR,j);
            polarscatter(deg2rad(angles-angleCorrection),abs(cellsMagnitude),dotSize,'filled','MarkerFaceColor',colour1)
        end
        if strcmp(lower(polarGraphic),'polarplot')
            cellsMagnitudeCat = horzcat(cellsMagnitude{:});
            anglesCat = horzcat(angles{:});
            anglesCat = anglesCat - deg2rad(angleCorrection);
            
            subplot(2,numSR,j);
            for nEdges = 1:length(anglesCat)
                polarplot([0 anglesCat(nEdges)],[0 abs(cellsMagnitudeCat(nEdges))],'LineWidth',lineWidth,'Color',colour1)
                hold on
            end
            hold off
        end
            
        ax=gca;
        ax.ThetaLimMode='manual';
        ax.ThetaLim=radLim;
        ax.GridAlpha=gridAlpha;
        ax.LineWidth=lineWidth;
        ax.FontSize=fontSize;
        ax.FontName=fontName;      
        title(['SR ' num2str(cellTablesVoronoi{i}.SR(j))])
    end
    
    %Frusta
    for j = 1:numSR
        cellsMagnitude = [];
        angles = [];
        for i = 1:size(cellTablesFrusta,1)
            valueFieldMagnitude =  getfield(cellTablesFrusta{i}, param1);
            valueFieldAngle =  getfield(cellTablesFrusta{i}, param2);
            cellsMagnitude = [cellsMagnitude, valueFieldMagnitude(j)];
            angles = [angles valueFieldAngle(j)];
        end

        if strcmp(lower(polarGraphic),'polarscatter')
           subplot(2,numSR,j+numSR);
           polarscatter(deg2rad(angles-angleCorrection),abs(cellsMagnitude),dotSize,'filled','MarkerFaceColor',colour2)
        end
        if strcmp(lower(polarGraphic),'polarplot')
             cellsMagnitudeCat = horzcat(cellsMagnitude{:});
            anglesCat = horzcat(angles{:});
            anglesCat = anglesCat - deg2rad(angleCorrection);

            subplot(2,numSR,j+numSR);

            for nEdges = 1:length(anglesCat)
                polarplot([0 anglesCat(nEdges)],[0 abs(cellsMagnitudeCat(nEdges))],'LineWidth',lineWidth,'Color',colour2)
                hold on
            end
            hold off
        end

        ax=gca;
        ax.ThetaLimMode='manual';
        ax.ThetaLim=radLim;
        ax.GridAlpha=gridAlpha;
        ax.LineWidth=lineWidth;
        ax.FontSize=fontSize;
        ax.FontName=fontName;           
        title(['SR ' num2str(cellTablesFrusta{i}.SR(j))])
    end
    
    savefig(h,dir2save)
    print(h,dir2save,'-dtiff','-r300')
    
    
    
end