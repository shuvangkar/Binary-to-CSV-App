function offset = get_offset(dataStruct)
[n,m] = size(dataStruct);

meanA = 0;
meanB = 0;
meanC = 0;
meanN = 0;
reverseStr = '';
for i = 1:n
    meanA = meanA + mean(dataStruct(i).data(1,:));
    meanB = meanB + mean(dataStruct(i).data(2,:));
    meanC = meanC + mean(dataStruct(i).data(3,:));
    meanN = meanN + mean(dataStruct(i).data(4,:));
    %%print progress 
    progress = (i/n)*100.0;
    msg = sprintf('Calculating offset: %3.1f \n', progress);
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));    

end

offset.meanA = meanA/n;
offset.meanB = meanB/n;
offset.meanC = meanC/n;
offset.meanN = meanN/n;
end