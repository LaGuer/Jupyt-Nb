function PartialSum(N)
 Sum=0.0 
 for n=1:2:N
   Sum += -1/n + 1/(n+1)
 end
 Sum
end
