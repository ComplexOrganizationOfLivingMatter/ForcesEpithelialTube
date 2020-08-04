function [newArray] = createArrayWithFixedSize(oldArray, fixedSize)
%CREATEARRAYWITHFIXEDSIZE Summary of this function goes here
%   Detailed explanation goes here
newArray = nan(fixedSize, 1);
newArray(1:length(oldArray)) = oldArray;
end

