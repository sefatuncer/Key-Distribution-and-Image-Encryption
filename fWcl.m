%% Wcl return
% Wcl as a matrix [0 1 0;1 0 0;0 0 1]
% Wcl's row is different from each other
% Wcl 3x3x(NxN)
function [a b c] = fWcl(d,i)
[max1,w1(i)] = max([d(i,1),d(i,2),d(i,3)]); % Index of maximum arguments -> w1(i)
[min1,w2(i)] = min([d(i,1),d(i,2),d(i,3)]); % Index of minimum arguments -> w2(i)
wcl(1,w1(i),i) = 1;
wcl(2,w2(i),i) = 1;
if w1(i)==1
	if w2(i)==2
    	wcl(3,3,i)=1;
    else
    	wcl(3,2,i)=1;
    end
	else if w1(i)==2
        if w2(i)==1
            wcl(3,3,i)=1;
        else
        	wcl(3,2,i)=1;
        end
    else if w1(i)==3
    	if w2(i)==1
        	wcl(3,2,i)=1;
    	else
        	wcl(3,1,i)=1;
        end
        end
	end
end %if w1(i)==1
[a b c] = [];
end % function