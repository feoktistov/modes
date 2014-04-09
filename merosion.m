function res = merosion(c)

res = c;
[w h] = size(c);

values = zeros(2,8);
for t = 1: 8
    values(1,t) = -1;
end; 

existZero = true;
while(existZero)
    existZero = false;
    for n = 2 : w-1
        for m = 2 : h-1
            if(res(n,m) == 0) 
                existZero = true;
                for k = -1 : 1
                    for s = -1 : 1
                        val = res(n+k,m+s);
                        cantFind = true;
                        for t = 1: 8
                            if(values(1,t)==val)
                               values(2,t) = values(2,t) + 1;
                               cantFind = false;
                            end;
                        end; 

                        if(cantFind) 
                          for t = 1: 8
                            if(values(1,t)==-1)
                               values(1,t) = val;  
                               values(2,t) = values(2,t) + 1;
                            end;
                          end;   
                        end;
                    end;
                end;

                max = 0;
                class = 0;
                for t = 1: 8
                  if(values(2,t) > max) 
                    max = values(2,t); 
                    class = values(1,t); 
                  end;
                end; 
                res(n,m) = class; 
            end;
        end;
    end;
end;