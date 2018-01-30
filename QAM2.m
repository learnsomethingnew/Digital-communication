function [p]= QAM2(mode,eb)
%simulate Pe for left 8-QAM
if mode == 1
    a = sqrt(eb/(3+sqrt(3))); %unit distance in constellation
    error = 0;                  %errors in simulation
    simu = 0;                   %number of simulation
    while true
        index = ceil(8*rand);   %pick which to transmit on average prob
        tx = lindex2coor(index,a);%change index to coordinates
        tx = tx + 1/sqrt(2)*randn*1+1/sqrt(2)*randn*i;%add noise
        rx = ldecision(tx,a);     %decode tx signal
        if rx == index
            simu = simu + 1;
        else
            error = error+1;
            simu = simu + 1;
        end
        if simu > 6500000 & error > 100
            break;
        end
        if error >= 500
            break;
        else
            continue;
        end
    end
    p = error/simu;           %simulation Pe
%simulate Pe for fat 8-QAM
elseif mode == 2
    a = sqrt(eb/6);           %unit distance in constellation
    error = 0;                %errors in simulation
    simu = 0;                 %number of simulation 
    while true
        index = ceil(8*rand); %pick which to transmit at equal prob
        tx = findex2coor(index,a);%change index to coordinates
        tx = tx + 1/sqrt(2)*randn+1/sqrt(2)*i*randn;%add noise
        rx = fdecision(tx,a);%decode rx signal
        if rx == index
            simu = simu + 1;
        else
            error = error+1;
            simu = simu + 1;
        end
        if simu > 6500000 & error > 100
            break;
        end
        if error >= 500
            break;
        else
            continue;
        end
    end
    p = error/simu; %simulation Pe
end
end
%decide which region rx belongs to for left 8-QAM
function [x] = ldecision(y,a)
c = a*[1+i,-1+i,-1-i,1-i,1+sqrt(3),i*(1+sqrt(3)),-(1+sqrt(3)),i*-(1+sqrt(3))];
d = zeros(1,8);
for k = 1:8
    d(k) = abs(y-c(k));
end
[z,x] = min(d);
end
%change index into coordinates for left 8-QAM
function [x] = lindex2coor(y,a)
c = a*[1+i,-1+i,-1-i,1-i,1+sqrt(3),i*(1+sqrt(3)),-(1+sqrt(3)),i*-(1+sqrt(3))];
x = c(y);
end
%decise which region rx belongs to for fat 8-QAM
function [x] = fdecision(y,a)
c = a*[-3+i,-1+i,1+i,3+i,-3-i,-1-i,1-i,3-i];
d = zeros(1,8);
for k = 1:8
    d(k) = abs(y-c(k));
end
[z,x] = min(d);
end
%change index into coordinates for fat 8-QAM
function [x] = findex2coor(y,a)
c = a*[-3+i,-1+i,1+i,3+i,-3-i,-1-i,1-i,3-i];
x = c(y);
end