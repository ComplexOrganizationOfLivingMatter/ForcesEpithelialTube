function compareTissueProperties(cellTablesVoronoi,cellTablesFrusta,numSR,colour, path2save)

    mkdir(path2save)

    angleCorrection = 0;
    radLim = [0,360];
    gridAlpha = 0.1;
    lineWidth = 1;
    fontSize = 12;
    dotSize = 6;
    fontName = 'Helvetica-Narrow';
    polarGraphic = 'polarScatter';
    
    %% Polar scatter major axis (length - angle)
    dir2save = [path2save 'PolarScatter_MajorAxis_Length_Angle_' date];
    param1 = 'majorAxisLength';
    param2 = 'cellOrientation';
    plotPolarGraphic(cellTablesVoronoi, cellTablesFrusta,param1,param2,polarGraphic,numSR,colour(2,:),colour(3,:),dotSize,angleCorrection,radLim,gridAlpha,lineWidth,fontSize,fontName,dir2save)      
    
    %% Polar scatter cell adhesion - cell orientation
    dir2save = [path2save 'PolarScatter_adhesionEnergy_Orientation_' date];
    param1 = 'adhesionEnergy';
    param2 = 'cellOrientation';
    plotPolarGraphic(cellTablesVoronoi, cellTablesFrusta,param1,param2,polarGraphic,numSR,colour(2,:),colour(3,:),dotSize,angleCorrection,radLim,gridAlpha,lineWidth,fontSize,fontName,dir2save)      
    
    %% Polar scatter axes relation - cell orientation
    dir2save = [path2save 'PolarScatter_AxesRelation_Orientation_' date];
    param1 = 'axesLengthRelation';
    param2 = 'cellOrientation';
    plotPolarGraphic(cellTablesVoronoi, cellTablesFrusta,param1,param2,polarGraphic,numSR,colour(2,:),colour(3,:),dotSize,angleCorrection,radLim,gridAlpha,lineWidth,fontSize,fontName,dir2save)      
    
    close all
   
end