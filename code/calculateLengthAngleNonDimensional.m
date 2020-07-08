function [edgesLength, edgesAngle] = calculateLengthAngleNonDimensional(verticesCell,l_c)
    verticesX = verticesCell(1:2:end);
    verticesY = verticesCell(2:2:end);

    edgesLength = zeros(1,length(verticesX)-1);
    edgesAngle = zeros(1,length(verticesX)-1);
    
    for i = 1:length(verticesX)-1
        l_edge = pdist2([verticesX(i),verticesY(i)],[verticesX(i+1),verticesY(i+1)]);
        edgesLength(i) = l_edge/l_c;
        edgesAngle(i) =  atan((verticesY(i+1)-verticesY(i))/(verticesX(i+1)-verticesX(i)));
    end
    
end


