function tableEnergies = calculateEnergiesFile(rawVerticesTable,adhesion,l_c,contractility,SR)
    tableEnergies = table();
    columnsTable = {'SR','cellID','neighboursIDs','vertexesXY','edgeLengthAngle','Area','Perimeter','Gamma','Lambda','l_c','adhesionEnergy','elasticEnergy','contractilityEnergy','numberOfApicoBasalTransitions'};
   
    for nSr = 1:length(SR)
        
        srTable = rawVerticesTable(ismember(rawVerticesTable.Radius,SR(nSr)),:);
        
        for nCell = 1:size(srTable,1) 
            tableEnergiesRow = array2table(zeros(1,length(columnsTable)),'VariableNames', columnsTable);
            row2check = srTable(nCell,:);
            tableEnergiesRow.SR = row2check.Radius;
            tableEnergiesRow.cellID = row2check.CellIDs;
            
            
            tableEnergies = [tableEnergies;tableEnergiesRow];
        end        
    end
end