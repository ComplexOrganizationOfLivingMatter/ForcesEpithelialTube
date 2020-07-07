function tableEnergies = calculateEnergiesFile(rawVerticesTable,adhesion,l_c,contractility,SR)
    tableEnergies = table();
    columnsTable = {'SR','cellID','tipCell','borderCell','neighboursIDs','vertexesXY','edgeLengthAngle','Area','Perimeter','Gamma','Lambda','l_c','adhesionEnergy','elasticEnergy','contractilityEnergy','numberOfApicoBasalTransitions'};
   
    for nSr = 1:length(SR)
        
        srTable = rawVerticesTable(ismember(rawVerticesTable.Radius,SR(nSr)),:);
        
        for nCell = 1:size(srTable,1) 
            tableEnergiesRow = array2table(zeros(1,length(columnsTable)),'VariableNames', columnsTable);
            row2check = srTable(nCell,:);
            tableEnergiesRow.SR = row2check.Radius;
            tableEnergiesRow.cellID = row2check.CellIDs;
            tableEnergiesRow.tipCell = row2check.TipCells;
            tableEnergiesRow.borderCell = row2check.BorderCell;
            %get neighbours from repeated vertices
            idsNeigh = obtainNeighboursIDs(srTable,tableEnergiesRow.cellID);
            
            tableEnergiesRow.neighboursIDs={idsNeigh};
            verticesCell = table2array(row2check(:,5:end));
            verticesCell(isnan(verticesCell))=[];
            
            calculateLengthAngleNonDimensional()
            
            verticesX = verticesCell(1:2:end);
            verticesY = verticesCell(2:2:end);
            
            
            tableEnergiesRow.vertexesXY = {verticesCell};
            
            tableEnergies = [tableEnergies;tableEnergiesRow];
        end        
    end
end