function cellsNeigh =  obtainNeighboursIDs(srTable,cellID)
    
rowCellID = srTable(ismember(srTable.CellIDs,cellID),:);

verticesCellID = rowCellID(:,5:end);
pairOfVertices = table2array(verticesCellID);
xs = pairOfVertices(:,1:2:end);
ys = pairOfVertices(:,2:2:end);
verticesXYCellID = [xs(:),ys(:)];
nanVert = isnan(xs(:));
verticesXYCellID(nanVert,:)=[];

allVertices = table2array(srTable(:,5:end));
allXs = allVertices(:,1:2:end);
allYs = allVertices(:,2:2:end);

cellWithPairedVertices = arrayfun(@(x,y) [x,y], allXs,allYs, 'UniformOutput',false);

idNeighs = cellfun(@(x) any(sum(ismember(x,verticesXYCellID),2)==2),cellWithPairedVertices);
[idX,~] = find(idNeighs);
idX = unique(idX);
allCellsIds = table2array(srTable(:,2));
cellsNeigh = unique(allCellsIds(idX));
cellsNeigh = cellsNeigh(cellsNeigh~=cellID);
end
            