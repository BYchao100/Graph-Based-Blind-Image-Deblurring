function gamma=CoeffOper2D(op,alpha,beta)
% This subroutine implement alpha op beta = gamma, where op= + - = * s n
Level=length(alpha);
[nD,nD1]=size(alpha{1});
for ki=1:Level
    if strcmp(op,'vs')
        vec=0;
        for ji=1:nD
            for jj=1:nD
                if (ji~=1 || jj~=1) && sum(sum(beta{ki}{ji,jj}))~=0
                    vec=vec+alpha{ki}{ji,jj}.^2;
                end
            end
        end
        vec=sqrt(vec);
    end
    for ji=1:nD
        for jj=1:nD
            if op=='='
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj};
            elseif op=='-'
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}-beta{ki}{ji,jj};
            elseif op=='+'
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}+beta{ki}{ji,jj};
            elseif op=='*'
                gamma{ki}{ji,jj}=alpha{ki}{ji,jj}*beta;
            elseif op=='s'
                gamma{ki}{ji,jj}=wthresh(alpha{ki}{ji,jj},'s',beta{ki}{ji,jj});
            elseif strcmp(op,'vs')
                if (ji~=1 || jj~=1) && sum(sum(beta{ki}{ji,jj}))~=0
                    gamma{ki}{ji,jj}=max(vec-beta{ki}{ji,jj},0).*(alpha{ki}{ji,jj}./(vec+1e-20));
                else
                    gamma{ki}{ji,jj}=alpha{ki}{ji,jj};
                end
            end
        end
    end
end