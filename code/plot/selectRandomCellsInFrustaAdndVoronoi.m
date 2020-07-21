function [outputTablesVoronoi, outputTablesFrusta] = selectRandomCellsInFrustaAdndVoronoi(nCells,voronoiTable,frustaTable)

%select cells into the bulk (no border cell and no tip cell)
rawTableVoronoi = voronoiTable;
rawTableFrusta = frustaTable;
idTipCell=voronoiTable.tipCell>0;
idBorderCell=voronoiTable.borderCell>0;
voronoiTable(idTipCell|idBorderCell,:)=[]; 

%SR1
idSr1=voronoiTable.SR==1;
voronoiTable(~idSr1,:)=[];

randCells = randi(size(voronoiTable,1),[nCells,1]);
chosenCells = voronoiTable(randCells,:);

outputTablesVoronoi = cell(nCells,1);
outputTablesFrusta = cell(nCells,1);

for nCell = 1:nCells
    fileNameVoronoi = chosenCells.fileNameCol(nCell);
    cellID = chosenCells.cellID(nCell);
    
    idFileNamesVor = cellfun(@(x) strcmp(x,fileNameVoronoi), rawTableVoronoi.fileNameCol);
    idCellIdsVor = rawTableVoronoi.cellID==cellID;
    idAndVor = idFileNamesVor & idCellIdsVor;
    outputTablesVoronoi{nCell} = rawTableVoronoi(idAndVor,:);
    
    fileNameFrusta = strrep(fileNameVoronoi{1},'Voronoi','Frusta');
    idFileNamesFrusta = cellfun(@(x) strcmp(x,fileNameFrusta), rawTableFrusta.fileNameCol);
    idCellIdsFrusta = rawTableFrusta.cellID==cellID;
    idAndFrusta = idFileNamesFrusta & idCellIdsFrusta;
    outputTablesFrusta{nCell} = rawTableFrusta(idAndFrusta,:);
    
end


end

