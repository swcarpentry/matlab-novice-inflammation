function output_range = range_overlap(varargin)

    % Return common overlap among a set of [low, high] ranges.

    lowest = -inf;
    highest = +inf;

    for i = 1:nargin
        range = varargin{i};
        low = range(1);
        high = range(2);
        lowest = max(lowest, low);
        highest = min(highest, high);
    end

    output_range = [lowest, highest];

end

% Solution to the exercise
%
% function output_range = range_overlap(varargin)
% 
% % Return common overlap among a set of [low, high] ranges.
% 
% lowest = -inf;
% highest = +inf;
% 
% for i = 1:nargin
%     range = varargin{i};
%     low = range(1);
%     high = range(2);
%     lowest = max(lowest, low);
%     highest = min(highest, high);
%     
%     % catch non-overlapping ranges
%     if low >= highest || high<=lowest
%         output_range=NaN;
%         return
%     end
% end
% 
% output_range = [lowest, highest];
% 
% end

