function res = mdilatation(c)

res = c;
[w h] = size(c);




for n = 2 : w-1
    for m = 2 : h-1
        class = 0;
        stop = false;
        for k = -1 : 1
            for s = -1 : 1
              if(stop)
                  %skip
              elseif(class == 0) 
                class = c(n+k, m+s);   
              elseif(c(n+k, m+s) ~= class)
                class = 0;  
                stop = true;  
              end;
            end;
        end;
        
        
        
        if(class == 0)
            values = zeros(2,8);
            for t = 1: 8
                values(1,t) = -1;
            end; 
            
            for k = -1 : 1
                for s = -1 : 1
                    val = c(n+k,m+s);
                    cantFind = true;
                    for t = 1: 8
                        if(values(1,t)==val)
                           values(2,t) = values(2,t) + 1;
                           cantFind = false;
                        end;
                    end; 

                    if(cantFind) 
                      for t = 1: 8
                        if(cantFind && values(1,t)==-1)
                           cantFind = false;
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
        end;
        res(n,m) = class;
    end;
end;
