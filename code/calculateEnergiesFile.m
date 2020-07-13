function tableEnergies = calculateEnergiesFile(rawVerticesTable,adhesion,l_c,contractility,SR,filePath2save)
    tableEnergies = table();
    columnsTable = {'SR','cellID','tipCell','borderCell','neighboursIDs','vertexesXY','edgesLength','edgesAngle','Area','Perimeter','Gamma','Lambda','l_c','adhesionEnergy','elasticEnergy','contractilityEnergy','numberOfApicoBasalTransitionsNext','isApicoBasalTransitionInNext'};
   
    for nSr = 1:length(SR)
        
        srTable = rawVerticesTable(ismember(round(rawVerticesTable.Radius,3),round(SR(nSr),3)),:);
        
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
            if verticesCell(1:2)== verticesCell(end-1:end)
                verticesCell = verticesCell(1:end-2);
            end
            tableEnergiesRow.vertexesXY = {verticesCell};

            %get non-dimensional edges -> l/l_c
            [ls_edge_nd, ls_angles] = calculateLengthAngleNonDimensional([verticesCell,verticesCell(1:2)],l_c);
            tableEnergiesRow.edgesLength = {ls_edge_nd};
            tableEnergiesRow.edgesAngle = {ls_angles};
            
            %get non-dimensional area -> area/l_c^2
            tableEnergiesRow.Area = polyarea(verticesCell(1:2:end),verticesCell(2:2:end))/(l_c^2);
            tableEnergiesRow.Perimeter = sum(ls_edge_nd);
            
            %init force inference parameters
            tableEnergiesRow.Gamma = contractility(nSr);
            tableEnergiesRow.Lambda = adhesion;
            tableEnergiesRow.l_c = l_c;
            
            tableEnergiesRow.adhesionEnergy = sum(ls_edge_nd) * adhesion;
            tableEnergiesRow.elasticEnergy = ((tableEnergiesRow.Area - 1)^2)/2;
            tableEnergiesRow.contractilityEnergy = (contractility(nSr)/2)*(sum(ls_edge_nd)^2);
            if nSr == 1
                tableEnergiesRow.numberOfApicoBasalTransitionsNext = 0;
                tableEnergiesRow.isApicoBasalTransitionInNext = 0;
            else
                %get number of apico-basal transition in next SR
                id2check = ismember(round(tableEnergies.SR,3),round(SR(nSr-1),3)) & (tableEnergies.cellID == tableEnergiesRow.cellID);
                rowAux2check = tableEnergies(id2check,:);
                rowAux2check = rowAux2check(1,:);
                nDifIntersection = length(setxor([rowAux2check.neighboursIDs{:}],idsNeigh));
                
                tableEnergiesRow.numberOfApicoBasalTransitionsNext = rowAux2check.numberOfApicoBasalTransitions + nDifIntersection;
                tableEnergies(id2check,:).numberOfApicoBasalTransitionsNext = repmat(rowAux2check.numberOfApicoBasalTransitions + nDifIntersection,sum(id2check),1);
                tableEnergies(id2check,:).isApicoBasalTransitionInNext= repmat(nDifIntersection>0,sum(id2check),1);
            end
            tableEnergies = [tableEnergies;tableEnergiesRow];
        end        
    end
    writetable(tableEnergies, [filePath2save '.xls']);
    save([filePath2save '.mat'],'tableEnergies')
end