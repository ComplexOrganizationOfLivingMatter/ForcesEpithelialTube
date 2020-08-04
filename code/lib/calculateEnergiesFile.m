function tableEnergies = calculateEnergiesFile(rawVerticesTable,adhesion,l_c,contractility,SR,filePath2save)
    tableEnergies = table();
    columnsTable = {'SR','cellID','tipCell','borderCell','neighboursIDs','vertexesXY','edgesLength','edgesAngle','Area','Perimeter','majorAxisLength','minorAxisLength','axesLengthRelation','cellOrientation','Gamma','Lambda','l_c','adhesionEnergy','elasticEnergy','contractilityEnergy','numberOfApicoBasalTransitionsNext','isApicoBasalTransitionInNext'};
   
    fixedNeighboursSize = 12;
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
            
            tableEnergiesRow.neighboursIDs={createArrayWithFixedSize(idsNeigh, fixedNeighboursSize)};
            verticesCell = table2array(row2check(:,5:end));
            verticesCell(isnan(verticesCell))=[];
            if verticesCell(1:2)== verticesCell(end-1:end)
                verticesCell = verticesCell(1:end-2);
            end
            
            tableEnergiesRow.vertexesXY = {createArrayWithFixedSize(verticesCell, fixedNeighboursSize*2)};

            %get non-dimensional edges -> l/l_c  && non-dimensional area -> area/l_c^2
            [ls_edge_nd, ls_angles, cellArea, cellPerimeter, cellMajorAxisLength, cellMinorAxisLength, cellOrientation] = calculateLengthAngleNonDimensional([verticesCell,verticesCell(1:2)],l_c);
            
            tableEnergiesRow.edgesLength = {createArrayWithFixedSize(ls_edge_nd, fixedNeighboursSize)};
            tableEnergiesRow.edgesAngle = {createArrayWithFixedSize(ls_angles, fixedNeighboursSize)};
            tableEnergiesRow.Area = cellArea;
            tableEnergiesRow.Perimeter = cellPerimeter;
            tableEnergiesRow.majorAxisLength = cellMajorAxisLength;
            tableEnergiesRow.minorAxisLength = cellMinorAxisLength;
            tableEnergiesRow.axesLengthRelation = cellMajorAxisLength/cellMinorAxisLength;
            tableEnergiesRow.cellOrientation = cellOrientation;
            
            
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
                
                tableEnergiesRow.numberOfApicoBasalTransitionsNext = rowAux2check.numberOfApicoBasalTransitionsNext + nDifIntersection;
                if rowAux2check.numberOfApicoBasalTransitionsNext == 0
                    tableEnergies(id2check,:).numberOfApicoBasalTransitionsNext = repmat(rowAux2check.numberOfApicoBasalTransitionsNext + nDifIntersection,sum(id2check),1);
                end
                tableEnergies(id2check,:).isApicoBasalTransitionInNext= repmat(nDifIntersection>0,sum(id2check),1);
            end
            tableEnergies = [tableEnergies;tableEnergiesRow];
        end        
    end
    writetable(tableEnergies, [filePath2save '.xls']);
    save([filePath2save '.mat'],'tableEnergies')
end