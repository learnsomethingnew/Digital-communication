M = 8;
frame = 130;
Eb = logspace(0,10,1300);
Pe = zeros(1,length(Eb));
constellation_a = [(1+sqrt(3))/2; 1/2+1/2*1i; (1+sqrt(3))/2*1i; -1/2+1/2*1i;...
    -(1+sqrt(3))/2; -1/2-1/2*1i; -(1+sqrt(3))/2*1i; 1/2-1/2*1i]';
constellation_b = [1.5+0.5*1i; 0.5+0.5*1i; -0.5+0.5*1i; -1.5+0.5*1i; -1.5-0.5*1i;...
    -0.5-0.5*1i; 0.5-0.5*1i; 1.5-0.5*1i]';
Eb_avg_a = (1/2 * ( (1+sqrt(3))/2 )^2 + 1/2 * 1/2)/3;
Eb_avg_b = (1/2 * 1/2 + 1/2 * 5/2)/3;
count = 0;
for ii = 1:length(Eb)
        if mod(ii,length(Eb)/10) == 0
             count = count + 1;
            fprintf('Case 1: Running: %2.0f%% \n', count*10)
        end
    error = 0;
   num_of_signal = 0;
   while(error<500)
       signal = ceil(rand(1,frame)*8);
       Sm = sqrt(Eb(ii)/Eb_avg_a)*constellation_a(signal);
       num_of_signal = num_of_signal + frame;
      n = randn(1,frame)*sqrt(2)/2 + randn(1,frame)*sqrt(2)/2*1i;
      r = Sm + n;
      for jj = 1:frame
          distance = inf;
          s_head = -1;
          for kk = 1:8
              if( abs(r(jj)-sqrt(Eb(ii)/Eb_avg_a)*constellation_a(kk)) < distance )                  
                  distance = abs(r(jj)-sqrt(Eb(ii)/Eb_avg_a)*constellation_a(kk));
                  s_head = kk;
              end
          end
          if (s_head ~= signal(jj))
              error = error+1;
          end
      end
     %pause;
   end
   Pe(ii) = error/num_of_signal;
end
x = 10*log10(Eb);
dmin = sqrt(Eb/Eb_avg_a);
upper = 3*qfunc(sqrt(dmin.^2/2));
lower = qfunc(sqrt(dmin.^2/2));
semilogy(x,Pe,x,upper,x,lower);