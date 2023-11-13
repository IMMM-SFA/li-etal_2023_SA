function [average_spanLength]=warm_event_length(TSA_detrend)

TSA_Z = zscore(TSA_detrend);

aboveThreshold = (squeeze(TSA_Z)>1)';
%              thresholdChange = [aboveThreshold(1) diff(aboveThreshold)];
%              thresholdChange(thresholdChange==-1) = 0;
%              spanLocs = cumsum(thresholdChange);
%              spanLocs(~aboveThreshold) = 0;
aboveThresholdIndex = find(aboveThreshold==1);
notConsecutiveIndex = [true diff(aboveThresholdIndex) ~= 1];
sumIndex = cumsum(notConsecutiveIndex);
spanLength = histc(sumIndex, 1:sumIndex(end));
average_spanLength = mean(spanLength);
%              goodSpans = find(spanLength>=1);
%              allInSpans = find(ismember(spanLocs, goodSpans));
