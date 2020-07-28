function [edgesLength, edgesAngle, cellArea, cellPerimeter, cellMajorAxisLength, cellMinorAxisLength, cellOrientation] = calculateLengthAngleNonDimensional(verticesCell,l_c)
    verticesX = verticesCell(1:2:end);
    verticesY = verticesCell(2:2:end);

    edgesLength = zeros(1,length(verticesX)-1);
    edgesAngle = zeros(1,length(verticesX)-1);
    
    for i = 1:length(verticesX)-1
        l_edge = pdist2([verticesX(i),verticesY(i)],[verticesX(i+1),verticesY(i+1)]);
        edgesLength(i) = l_edge/l_c;
        edgesAngle(i) =  atan((verticesY(i+1)-verticesY(i))/(verticesX(i+1)-verticesX(i)));
    end
    
    cellArea = polyarea(verticesX,verticesY)/(l_c^2);
    cellPerimeter = sum(edgesLength);
    
    %avoid negative vertices to convert polygon to image
    if any(verticesY<0)
        verticesY = verticesY + abs(min(verticesY))+1;
    end
    if any(verticesX<0)
        verticesX = verticesX + abs(min(verticesX))+1;
    end
    bw = poly2mask(verticesX,verticesY,ceil(max(verticesY)),ceil(max(verticesX)));
       
%     imshow(bw)
%     hold on
%     plot(verticesX,verticesY,'b','LineWidth',2)
%     hold off
%     close all
    infoCell = regionprops(bw,'MajorAxisLength','MinorAxisLength','Orientation');
    
    cellMajorAxisLength = infoCell.MajorAxisLength/l_c;
    cellMinorAxisLength = infoCell.MinorAxisLength/l_c;
    cellOrientation = infoCell.Orientation;
    
    
    
    
end


