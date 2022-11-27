function dist = getDist_dis(p,m,p_a)
    TM =spalloc(p.nzz*p.naa,p.nzz*p.naa,p.nzz*p.naa*2*p.nzz);
    for i = 1:p.naa      
        for j = 1:p.nzz
             TM((i-1)*p.nzz+j,(p_a(j,i)-1)*p.nzz+1:p_a(j,i)*p.nzz) = m.Pi(j,:);  
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