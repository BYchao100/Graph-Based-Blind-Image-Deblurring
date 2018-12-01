
  function cn = cellnorm2D(x,type)

  if (nargin == 1); type = 2; end

  if iscell(x)
     Level    = length(x);
     [nD,nD1] = size(x{1});
     cn = 0;
     for L=1:Level
        for ii=1:nD
           for jj=1:nD
              if (type==2)
                 cn = cn + norm(x{L}{ii,jj},'fro')^2;
  	      elseif (type==1)
                 cn = cn + sum(sum(abs(x{L}{ii,jj}))); 
              end
           end
        end
     end
     if (type==2); cn = sqrt(cn); end
  else
     if (type==2)
        cn = norm(x,'fro'); 
     elseif (type==1)
        cn = sum(sum(abs(x))); 
     end
  end
  cn = full(cn); 
