function [dist,TM] = getDist_cnsJ(p,m,g_a)
    indbelow = ones(p.nzz,p.naa);
    for i=2:p.naa
        indbelow(g_a>=m.a_grid(i))=i;
    end
    indbelow = min(indbelow,p.naa-1);
    indabove = indbelow + 1;
    wabove = (g_a-m.a_grid(indbelow))./(m.a_grid(indbelow+1)-m.a_grid(indbelow));
    wabove = min(wabove,1); 
    wabove = max(wabove,0);
    wbelow= 1-wabove;
    TM =spalloc(p.nzz*p.naa,p.nzz*p.naa,p.nzz*p.naa^2*p.nzz);
    for i = 1:p.naa      
        for j = 1:p.nzz
             TM((i-1)*p.nzz+j,(indbelow(j,i)-1)*p.nzz+1:(indbelow(j,i))*p.nzz) = wbelow(j,i)*m.Pi(j,:);  
             TM((i-1)*p.nzz+j,(indabove(j,i)-1)*p.nzz+1:(indabove(j,i))*p.nzz) = wabove(j,i)*m.Pi(j,:);  
        end
    end
    probst = (1/(p.nzz*p.naa))*ones(1,p.nzz*p.naa); 
    err = 1;
    while err > p.tol                
       probst1 = probst*TM;
       err = max(abs(probst1-probst));
       probst = probst1; 
    end
    dist=reshape(probst,p.nzz,p.naa);
end